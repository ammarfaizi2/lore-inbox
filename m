Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbSL2GUO>; Sun, 29 Dec 2002 01:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266489AbSL2GUO>; Sun, 29 Dec 2002 01:20:14 -0500
Received: from dp.samba.org ([66.70.73.150]:38045 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266480AbSL2GUM>;
	Sun, 29 Dec 2002 01:20:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Zhuang, Louis" <louis.zhuang@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] fix os release detection in module-init-tools-0.9.6 
In-reply-to: Your message of "Sat, 28 Dec 2002 18:38:54 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2601AA1378@pdsmsx32.pd.intel.com> 
Date: Sun, 29 Dec 2002 16:54:58 +1100
Message-Id: <20021229062833.1598F2C085@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2601AA1378@pdsmsx32.pd.intel.com> you
 write:
> > Now, why do you want /proc/ksyms exactly?  I'm not hugely opposed to
> > it, but it's rarely what people actually want, since it contains only
> > exported symbols.
> The two things make me want ksyms... ;-)

> First, if I'm a stranger to a system, how can I know if a feature
> (preemptive, for example) is on/off on that?

Um, you read the .config, which hopefully is stored somewhere.
(Although you could resurrect the /proc/config patch which goes around
every so often).  There are many things you can't tell by reading
/proc/ksyms.

> Second, when module version is back, how can I know what is the magic
> version number on the system?

Well, the new version system is a little different.  (I've been
distracted by other things, but un-bitrotting that patch is on my TODO
list).  The idea is that modules have a ".versions" section, which
contains the versions of all the symbols it exports and requires.
When the module is loaded into a kernel with version support, the
version of each symbol is compared: if it's different, the module
can't be loaded.  If it's missing (or the entire section is missing),
the module can be loaded, but taints the kernel.

This allows versioned modules to be loaded into an unversioned kernel
and vice versa, which might be useful.  modprobe just needs a
--strip-version option to rename the .versions section (or remove it,
or whatever), and the picture is complete.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
