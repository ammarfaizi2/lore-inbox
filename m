Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264532AbUD1ACd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbUD1ACd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 20:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUD1ACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 20:02:32 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:24000 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264519AbUD1ACJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 20:02:09 -0400
In-Reply-To: <1083107550.30985.122.camel@bach>
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: pmarques@grupopie.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       malda@slashdot.org, c-d.hailfinger.kernel.2004@gmx.net,
       Linus Torvalds <torvalds@osdl.org>, jon787@tesla.resnet.mtu.edu
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Tue, 27 Apr 2004 20:02:03 -0400
To: Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty, the workaround was done a while ago, back in the 2.5 days when 
your new module code
was still very much in flux. It was necessary to have an effective 
short-term solution for the existing
installed base (2.4), since we could not continue to confuse customers 
while waiting for the patch
to propagate. In other cases, we have gladly submitted patches when we 
encountered bugs and
could fix them. Had we known that the module fix was so simple, it 
would of course have been
submitted it to you in parallel.

Also since you and I have worked well together in other projects 
(netfilter core) and are long time friends,
I don't understand why you are so quick to question my integrity in 
public. We didn't lie about anything;
the license text is perfectly clear, and the political situation with 
Conexant's proprietary signal processing
code outside of our control.

Marc

--
Marc Boucher
Linuxant inc.

On Apr 27, 2004, at 7:12 PM, Rusty Russell wrote:

> On Wed, 2004-04-28 at 02:58, Marc Boucher wrote:
>> Actually, we also have no desire nor purpose to prevent tainting. The 
>> purpose
>> of the workaround is to avoid repetitive warning messages generated 
>> when
>> multiple modules belonging to a single logical "driver"  are loaded 
>> (even when
>> a module is only probed but not used due to the hardware not being 
>> present).
>
> You lied about the license, rather than submit a one-line change to
> kernel/module.c.
>
> This shows a lack of integrity that I find personally repulsive.
>
> Name: Only Print Taint Message Once
> Status: Trivial
>
> Only print the tainted message the first time.  Its purpose is to warn
> users that we can't support them, not to fill their logs.
>
> diff -urpN --exclude TAGS -X 
> /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal 
> .22310-linux-2.6.6-rc2-bk5/kernel/module.c 
> .22310-linux-2.6.6-rc2-bk5.updated/kernel/module.c
> --- .22310-linux-2.6.6-rc2-bk5/kernel/module.c	2004-04-22 
> 08:04:00.000000000 +1000
> +++ .22310-linux-2.6.6-rc2-bk5.updated/kernel/module.c	2004-04-28 
> 09:03:31.000000000 +1000
> @@ -1131,7 +1131,7 @@ static void set_license(struct module *m
>  		license = "unspecified";
>
>  	mod->license_gplok = license_is_gpl_compatible(license);
> -	if (!mod->license_gplok) {
> +	if (!mod->license_gplok && !(tainted & TAINT_PROPRIETARY_MODULE)) {
>  		printk(KERN_WARNING "%s: module license '%s' taints kernel.\n",
>  		       mod->name, license);
>  		tainted |= TAINT_PROPRIETARY_MODULE;
>
> -- 
> Anyone who quotes me in their signature is an idiot -- Rusty Russell
>

