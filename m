Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbSL1GSc>; Sat, 28 Dec 2002 01:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSL1GSc>; Sat, 28 Dec 2002 01:18:32 -0500
Received: from dp.samba.org ([66.70.73.150]:31714 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265513AbSL1GS1>;
	Sat, 28 Dec 2002 01:18:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Zhuang, Louis" <louis.zhuang@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix os release detection in module-init-tools-0.9.6 
In-reply-to: Your message of "Sat, 28 Dec 2002 13:49:49 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2601AA1377@pdsmsx32.pd.intel.com> 
Date: Sat, 28 Dec 2002 17:12:56 +1100
Message-Id: <20021228062644.83BF62C06B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2601AA1377@pdsmsx32.pd.intel.com> you
 write:
> Dear Rusty,
> 	IMHO, try_old_version can tell kernel release better with this
> patch, don't you? ;->
>   - Louis

I prefer, in principle, to test for features, not kernel versions.
What about 2.1, for example?

I've changed the check to sys_create_module(NULL, 0) != -ENOSYS,
instead, which should cover everything.

Now, why do you want /proc/ksyms exactly?  I'm not hugely opposed to
it, but it's rarely what people actually want, since it contains only
exported symbols.

My plan was to change the format of /proc/modules slightly to make it
extensible (patch on my page), then add the "start of module"
parameter, which should allow ksymoops and oprofile to handle modules
cleanly again (although ksymoops is less urgent since CONFIG_KALLSYMS
does such a nice job for most things).

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
