Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVAYVYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVAYVYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbVAYVM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:12:56 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:25872 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262151AbVAYVHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:07:35 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 6/12] random pt4: Replace SHA with faster version
Date: Tue, 25 Jan 2005 23:07:21 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <7.314297600@selenic.com>
In-Reply-To: <7.314297600@selenic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252307.21993.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 23:41, Matt Mackall wrote:
> - * @W:      80 words of workspace
> + * @W:      80 words of workspace, caller should clear

Why?

>   *
>   * This function generates a SHA1 digest for a single. Be warned, it
>   * does not handle padding and message digest, do not confuse it with
>   * the full FIPS 180-1 digest algorithm for variable length messages.
>   */
> -void sha_transform(__u32 *digest, const char *data, __u32 *W)
> +void sha_transform(__u32 *digest, const char *in, __u32 *W)
>  {
> -	__u32 A, B, C, D, E;
> -	__u32 TEMP;
> -	int i;
> +	__u32 a, b, c, d, e, t, i;
>  
> -	memset(W, 0, sizeof(W));
>  	for (i = 0; i < 16; i++)
> -		W[i] = be32_to_cpu(((const __u32 *)data)[i]);
> -	/*
> -	 * Do the preliminary expansion of 16 to 80 words.  Doing it
> -	 * out-of-line line this is faster than doing it in-line on
> -	 * register-starved machines like the x86, and not really any
> -	 * slower on real processors.
> -	 */
> -	for (i = 0; i < 64; i++) {
> -		TEMP = W[i] ^ W[i+2] ^ W[i+8] ^ W[i+13];
> -		W[i+16] = rol32(TEMP, 1);
> +		W[i] = be32_to_cpu(((const __u32 *)in)[i]);
> +
> +	for (i = 0; i < 64; i++)
> +		W[i+16] = rol32(W[i+13] ^ W[i+8] ^ W[i+2] ^ W[i], 1);
--
vda

