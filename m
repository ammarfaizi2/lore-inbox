Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262688AbVA0SV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbVA0SV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVA0SUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:20:11 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:55948 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262693AbVA0STX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:19:23 -0500
Message-ID: <41F93164.9000508@tmr.com>
Date: Thu, 27 Jan 2005 13:22:28 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SHA1 clarify kerneldoc
References: <200501252331.19527.vda@port.imtp.ilyichevsk.odessa.ua><200501252331.19527.vda@port.imtp.ilyichevsk.odessa.ua> <20050125215015.GQ12076@waste.org>
In-Reply-To: <20050125215015.GQ12076@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Tue, Jan 25, 2005 at 11:31:19PM +0200, Denis Vlasenko wrote:
> 
>>On Tuesday 25 January 2005 23:14, Matt Mackall wrote:
>>
>>>On Tue, Jan 25, 2005 at 11:07:21PM +0200, Denis Vlasenko wrote:
>>>
>>>>On Friday 21 January 2005 23:41, Matt Mackall wrote:
>>>>
>>>>>- * @W:      80 words of workspace
>>>>>+ * @W:      80 words of workspace, caller should clear
>>>>
>>>>Why?
>>>
>>>Are you asking why should the caller clear or why should it be cleared at all?
>>>
>>>For the first question, having the caller do the clear avoids
>>>redundant clears on repeated calls.
>>>
>>>For the second question, forward security. If an attacker breaks into
>>>the box shortly after a secret is generated, he may be able to recover
>>>the secret from such state.
>>
>>Whoops. I understood a comment as 'caller should clear prior to use'
>>and this seems to be untrue (code overwrites entire W[80] vector
>>without using prior contents).
>>
>>Now I think that you most probably meant 'caller should clear AFTER use'.
>>If so, comment should be amended.
> 
> 
> Indeed.
> 
> Index: rc2mm1/lib/sha1.c
> ===================================================================
> --- rc2mm1.orig/lib/sha1.c	2005-01-25 09:31:59.000000000 -0800
> +++ rc2mm1/lib/sha1.c	2005-01-25 13:48:34.000000000 -0800
> @@ -25,11 +25,15 @@
>   *
>   * @digest: 160 bit digest to update
>   * @data:   512 bits of data to hash
> - * @W:      80 words of workspace, caller should clear
> + * @W:      80 words of workspace (see note)
>   *
>   * This function generates a SHA1 digest for a single. Be warned, it
                                                   ^^^^^^
Is this a term I don't know, "single" as a noun, or should "512 bit 
block" follow, as it does in crypto/sha1 from rc1-bk1 which is what I 
have handy?

>   * does not handle padding and message digest, do not confuse it with
>   * the full FIPS 180-1 digest algorithm for variable length messages.
> + *
> + * Note: If the hash is security sensitive, the caller should be sure
> + * to clear the workspace. This is left to the caller to avoid
> + * unnecessary clears between chained hashing operations.
>   */
>  void sha_transform(__u32 *digest, const char *in, __u32 *W)
>  {
> 
> 


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
