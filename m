Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUIWKhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUIWKhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 06:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268379AbUIWKhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 06:37:46 -0400
Received: from share.sks3.muni.cz ([147.251.211.22]:37072 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S268372AbUIWKhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 06:37:40 -0400
Date: Thu, 23 Sep 2004 12:37:23 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
Message-ID: <20040923103723.GA12145@mail.muni.cz>
References: <20040923100906.GB11230@mail.muni.cz> <20040923031451.56147952.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040923031451.56147952.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 03:14:51AM -0700, Andrew Morton wrote:
> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> >
> > Sep 23 11:26:24 debian kernel: EIP:    0060:[fn_hash_insert+1039/1159]    Tainted:  P   VLI
> > 
> 
> This might fix it
> 
> --- a/net/ipv4/fib_hash.c	2004-09-23 03:13:49 -07:00
> +++ b/net/ipv4/fib_hash.c	2004-09-23 03:13:49 -07:00
> @@ -536,7 +536,7 @@
>  		 * information.
>  		 */
>  		fa_orig = fa;
> -		list_for_each_entry(fa, fa->fa_list.prev, fa_list) {
> +		list_for_each_entry(fa, fa_orig->fa_list.prev, fa_list) {
>  			if (fa->fa_info->fib_priority != fi->fib_priority)
>  				break;
>  			if (fa->fa_type == type &&

It has fixed it.

However there is still the issue with endless loop in fn_hash_delete :(

-- 
Luká¹ Hejtmánek
