Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317437AbSFRPA3>; Tue, 18 Jun 2002 11:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317438AbSFRPA2>; Tue, 18 Jun 2002 11:00:28 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:33932 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317437AbSFRPA2>; Tue, 18 Jun 2002 11:00:28 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 18 Jun 2002 08:00:23 -0700
Message-Id: <200206181500.IAA00339@baldur.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de
Subject: Re: Various kbuild problems in 2.5.22
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 18 Jun 2002, Adam J. Richter wrote:

>> 	I would like to note the following problems with the
>> kernel build process in 2.5.22, after applying the patch that
>> Kai Germaschewski posted that enabled modversions to work again.
>> All but the first one are spurious dependencies.

>> #define __ver_pcmcia_get_mem_page_Rsmp_3d2ded54 smp_ba03375b
>> #define pcmcia_get_mem_page_Rsmp_3d2ded54       _set_ver(pcmcia_get_mem_page_Rsmp_3d2ded54)

>Yes, the fix I posted was not complete. I submitted a corrected one 
>already.

>> 	2. "make bzImage" does not build a bzImage if any module fails
>> to compile.  Really, it should not attempt to buidl modules or even
>> descend into directories that contain only modules.  To build a bzImage,
>> I have to edit the Makefile and comment out "BUILD_MODULES:=1".

>That's intentional. If you don't want to build modules, use "make 
>KBUILD_MODULES= bzImage". Or you can just ignore errors using "make -k".

	No, "make -k" still will not build bzImage if a module
fails to compile.

	Also, I do not understand why this is "intentional."  Normally,
if one does a "make" of a file in a source tree, build problems with
unneeded files do not effect it.


>> 	3. make include/linux/modversios.h aborts if any .c file has
>> a #error or #include's a .h that is not present (for example, because
>> the .h is built by the process, as is the case with one scsi driver).

>The fact that it aborts is intentional.

	We have adopted a convention of putting #error into lots
of device drivers to encourage people to port them.  Linus has
also recently integrated chagnes to support compiling with "all
modules" and "all yes" configurations.  This change makes that
facility useless.

	I do not think it improves anyone's prioritization to
require everyone to either make custom kernel configurations or
give top priority to fixing random drivers ahead of whatever
else depends on their getting the new kernel to build.


>That it doesn't build the .h in that case is a bug. Which driver is it?

	53c700.  The generated header file is drivers/scsi/53c700_d.h.

>> 	4. "make -k modules" will not build perfectly buildable modules
>> in a directory that has a subdirectory where a compile error occurs.

>Well, I can fix that, I'll look into it.

	Great.  Thanks.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
