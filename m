Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264397AbRFTIBG>; Wed, 20 Jun 2001 04:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbRFTIAz>; Wed, 20 Jun 2001 04:00:55 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:25606 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S264397AbRFTIAk>; Wed, 20 Jun 2001 04:00:40 -0400
Message-ID: <3B3057BE.4374D4B2@idb.hist.no>
Date: Wed, 20 Jun 2001 09:58:54 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "McHarry, John" <john.mcharry@gemplex.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
In-Reply-To: <A5F553757C933442ADE9B31AF50A273B028DB4@corp-p1.gemplex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"McHarry, John" wrote:
> 
> I am trying to compile the 2.2.19 kernel one one machine for  installation
> on another.  I believe I need to do more than just copy over  bzImage and
> modify lilo.conf, but I don't know what.  Is there documentation somewhere
> on how to do this?  Thanks.

This is enough if you don't use modules.  If you use modules you
need to copy them too, which is trickier.  Several good methods
have been demonstrated, here is another if you can't use the nfs
approach:

1. If you are running the same kernel revision on the compile machine,
   temporarily rename /lib/modules/<version> to something else.
   Yes - this could be dangerous but tend to work well on a "home
machine"
2. Do the "make modules_install" on the compile machine.
3. Rename the /lib/modules/<version> to something else, and
   rename your proper module directory back to what it should be.
4. Transfer the installed module tree to the target machine along with
   the bzImage.

The "dangerous part" happens if the kernel on the compile machine
tries to load a module between step 1 and step 3.
This can be avoided in a number of ways, such as:

* Make sure the target and compile machines run different kernel
revisions.
  If you're upgrading both, compile for the target machine first.
  Or edit the makefile, append something like "target" to the
"extraversion",
  you will then get the modules installed in
/lib/modules/<version>target
  which is different from what your compile machine uses.

* Use "chroot" so make modules_install will install somewhere else.
  info|man chroot for details.
 
Helge Hafting
