Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbTACGRx>; Fri, 3 Jan 2003 01:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTACGRx>; Fri, 3 Jan 2003 01:17:53 -0500
Received: from dp.samba.org ([66.70.73.150]:39861 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267426AbTACGRv>;
	Fri, 3 Jan 2003 01:17:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Wang, Stanley" <stanley.wang@intel.com>
Cc: "Zhuang, Louis" <louis.zhuang@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: Kernel module version support. 
In-reply-to: Your message of "Fri, 03 Jan 2003 13:36:19 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2601F1170F@pdsmsx32.pd.intel.com> 
Date: Fri, 03 Jan 2003 16:54:25 +1100
Message-Id: <20030103062622.4945B2C052@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2601F1170F@pdsmsx32.pd.intel.com> you
 write:
> Hi Rusty
> Thanks for your rapid responding.
> 
> And as you are the maintainer of kernel module support, I would like to know
> how
> you think about export some APIs for geting a specified module structure's
> pointer.
> Just like:
> struct module *get_module(const char *name)
> {
> 	struct module *mod;
> 	down(&module_mutex);
> 	mod = find_module(name);
> 	up(&module_mutex);
> 	return mod;
> }
> EXPORT_SYMBOL_GPL(get_module);

Well, you also need:
      if (mod && !try_module_get(mod))
		mod = NULL; /* Not ready, or vanishing.  Ignore. */

Just before the "up(&module_mutex);".

I'm not convinced you don't want some other, more powerful interface,
though, like "get_ksymbol_address()" or something.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
