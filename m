Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUBUMoT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 07:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUBUMoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 07:44:19 -0500
Received: from everest.2mbit.com ([24.123.221.2]:35818 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261257AbUBUMoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 07:44:17 -0500
Message-ID: <40375261.6030705@greatcn.org>
Date: Sat, 21 Feb 2004 20:43:13 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
Organization: GreatCN.org & The Summit Open Source Develoment Group
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
References: <c16rdh$gtk$1@terminus.zytor.com>
In-Reply-To: <c16rdh$gtk$1@terminus.zytor.com>
X-Scan-Signature: f4a2161a70e9ca874377242522da36ff
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: Re: BOOT_CS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 3.1 (built Tue Oct 14 21:11:59 EST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Anyone happen to know of any legitimate reason not to reload %cs in
> head.S?  I think the following would be a lot cleaner, as well as a
> lot safer (the jump and indirect branch aren't guaranteed to have the
> proper effects, although technically neither should be required due to
> the %cr0 write):
> 
> @@ -117,10 +147,7 @@
>         movl %cr0,%eax
>         orl $0x80000000,%eax
>         movl %eax,%cr0          /* ..and set paging (PG) bit */
> -       jmp 1f                  /* flush the prefetch-queue */
> -1:
> -       movl $1f,%eax
> -       jmp *%eax               /* make sure eip is relocated */
> +       ljmp $__BOOT_CS,$1f     /* Clear prefetch and normalize %eip
> */
>  1:
>         /* Set up the stack pointer */
>         lss stack_start,%esp
> 
> 
> I've been doing some cleanups in head.S after making the early page
> tables dynamic.
> 
> 	-hpa
> -

IMHO, why bother to re-reload %cs again?

In setup.S, %cs is reloaded already. The enable paging code maps the
address identically, so %cs already contains the proper selector.


Coywolf


-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

