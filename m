Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278525AbRJVLRs>; Mon, 22 Oct 2001 07:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278563AbRJVLRk>; Mon, 22 Oct 2001 07:17:40 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:16 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278525AbRJVLR2>;
	Mon, 22 Oct 2001 07:17:28 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: Your message of "Mon, 22 Oct 2001 05:34:43 -0400."
             <Pine.GSO.4.21.0110220526480.2294-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 21:17:48 +1000
Message-ID: <25634.1003749468@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 05:34:43 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Mon, 22 Oct 2001, Keith Owens wrote:
>> In modutils 2.5 I will get rid of all the hard coded entries in
>> util/alias.h.  Instead each module will define what it supports,
>> including any special commands to be run when the module is loaded or
>> unloaded.  Much easier for everyone and far more flexible.
>
>Heh.  OK, so you've stopped me in the middle of writing RFC that proposes
>addition of
>MODULE_CONF(string)

Strange, that was exactly what I was planning for 2.5 :).

>that would put that string into separate section and making modules_install

<pedantic>
depmod, not modules_install, depmod is run at other times.
</pedantic>

>dump these sections, feed them through s/_NAME_/`basename $module`/ and

kbuild 2.5 does -DKBUILD_OBJECT=module_name for all objects linked into
a module.  KBUILD_OBJECT defines the overall module, not the individual
files that make up the module.  We have the technology!

>cat them into defaults file that would go into $INSTALL_MOD_PATH.

Just another modules.* file, probably modules.dynamic.conf.

BTW, INSTALL_MOD_PATH is dead in kbuild 2.5, it is a configuration
option and is held in .config.

>MODULES_BLKDEV(), MODULE_LDISC(), etc. would be trivial wrappers around that.

Everything is a device and can be handled by the hotplug project.  It
is really a cunning plan by David Brownell and Greg Kroah-Hartman to
own the entire device subsystem ;).

>Looks like the thing you mentioned would make quite a few people happy.
>Might be worth doing in 2.4...

Please, no more 2.4 changes.  Let Linus get 2.4 stable, fork 2.5 so we
can break it on a daily basis then backport to 2.4 when it works.

