Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTI3LrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 07:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbTI3LrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 07:47:07 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:65191 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261352AbTI3LrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 07:47:04 -0400
Date: Tue, 30 Sep 2003 13:44:30 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200309301144.h8UBiUUF004315@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From axboe@suse.de  Tue Sep 30 13:05:18 2003

>On Tue, Sep 30 2003, Joerg Schilling wrote:
>> A year after I did report this inconsistency, it is still not fixed
>> 
>> If include/scsi/scsi.h is included without __KERNEL__ #defined, then this
>> error message apears.
>> 
>> /usr/src/linux/include/scsi/scsi.h:172: parse error before "u8"
>> /usr/src/linux/include/scsi/scsi.h:172: warning: no semicolon at end of struct 
>> or union
>> /usr/src/linux/include/scsi/scsi.h:173: warning: data definition has no type or 
>> storage class
>> 
>> Is there no interest in user applications for kernel features or is there just
>> no kernel maintainer left over who makes the needed work?

>/usr/include/scsi/scsi.h looks fine on my system, probably also on
>yours. You should not include kernel headers in your user space program.

Looks like you did not understand the background :-(

In order to use kernel interfaces you _need_ to include kernel include files.

This is in particular true as long as we are talking about beta/testing kernels.


Background: on homogeneous platforms like e.g. Solaris or FreeBSD which are
	maintained and distributed as whole, an _enduser_ should include
	files from /usr/include only. 

	This is not even true for people who do Solaris or FreeBSD kernel 
	development and like to test new features with user level programs.
	It is definitely not true for compilations against Linux kernel
	interfaces.

Linux is not a homogeneous system. There is a separately developed kernel and 
a separate base user level system. People often install a newer kernel and need 
to recompile software because the kernel/user interfaces are not stable between
different Linux releases.

These people need to compile against the recent Linux kernel include files if
they use Linux kernel <-> user level interfaces.

-	... why do you believe that #ifdef __KERNEL__ kernel do exist inside 
	Linux kernel include files if they are not intended for user level 
	programs?

-	How should user level program that depend on kernel interfaces be 
	compiled if not by using kernel include files?


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
