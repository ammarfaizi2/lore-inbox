Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131371AbQKJSpE>; Fri, 10 Nov 2000 13:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131391AbQKJSoy>; Fri, 10 Nov 2000 13:44:54 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:35499 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131067AbQKJSom>; Fri, 10 Nov 2000 13:44:42 -0500
Message-Id: <5.0.0.25.2.20001110183746.00ac0e60@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Fri, 10 Nov 2000 18:44:58 +0000
To: georgn@somanetworks.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: compiling 2.4.0-test10 kernel 
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <14860.15798.651952.347977@somanetworks.com>
In-Reply-To: <7531.973877015@ocs3.ocs-net>
 <14860.8449.485106.841805@somanetworks.com>
 <7531.973877015@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:25 10/11/2000, Georg Nikodym wrote:
>OK, but I guess my question wasn't very clear.  I have a kernel tree,
>I add a printk to maestro.c and make modules.  I cannot load the
>module until I rebuild and reinstall everything.  Is there a way to
>avoid this headache, or, stated differently:  What's the prescribed
>way to be able to load, unload, build, test modules?

I do the following when I am working on the NTFS driver:

1st: make mrproper && make menuconfig && make dep && make bzImage && make 
modules && make modules_install
2nd: install new kernel, lilo, reboot into new kernel
3rd: edit the <mymodule>'s source.
4th: make modules && make modules_install && depmod -a && rmmod <mymodule> 
&& modprobe <mymodule>
5th: do testing I wanted to do.
6th go to 3rd step and repeat until satisfied with result.

[NB. Obviously replacing <mymodule> with the module name of whatever I am 
looking at.
NB. I have put this in a few convenience scripts...]

This procedure works fine, or at least it does so for all modules I have 
tried it with (which isn't many, since I only keep NTFS, md and linear as 
modules...).

HTH,

         Anton

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
