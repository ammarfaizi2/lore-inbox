Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312720AbSDFT6h>; Sat, 6 Apr 2002 14:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312734AbSDFT6g>; Sat, 6 Apr 2002 14:58:36 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:50450 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S312720AbSDFT6g>; Sat, 6 Apr 2002 14:58:36 -0500
Message-Id: <200204061958.g36Jw7987298@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: Your message of "Sat, 06 Apr 2002 20:06:27 +1000."
             <17430.1018087587@ocs3.intra.ocs.com.au> 
Date: Sat, 06 Apr 2002 12:58:07 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Standardize the makefiles for aic7xxx and aic7xxx/aicasm.
>  Use standard kbuild 2.4 rules.

Are these documented somewhere?  I emulated "scsi/Makefile" some
time back, but it must be out of date with current conventions.

Three other quick questions:

1) Why doesn't "make dep" pickup the dependencies you have added
   explicitly the aic7xxx/Makefile?  I would expect at least this
   dependency to be picked up:

+
+# Only aic7xxx_core.c includes aic7xxx_seq.h.
+aic7xxx_core.o: aic7xxx_seq.h

    The other, indirect, dependencies (through aic7xxx.h) are picked
    up in every other OS this driver supports.  I suppose "make dep"'s
    shortcuts mean you have to hard code stuff to make it work.

2) Are there plans to allow "down tree" Makefiles to list there own
   clean files?  Having to modify the top level Makefile is a bit messy.

3) Why remove the ability to override the module target name?  I eventually
   renamed my driver's main file to avoid this issue because I will be adding
   a second driver to the aic7xxx/Makefile (U320), but this same thing
   will probably come up again.

Lastly, I'm not sure why there was a discrepancy between aic7xxx_drv.o
and aic7xxx.o.  I just checked my local tree, and scsi/Makefile was
already corrected.  I will have to verify the files in the future, post
merge, to make sure all of the changes have been accepted.

Thanks for you help on this.

--
Justin
