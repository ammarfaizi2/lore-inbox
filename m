Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312883AbSDBSah>; Tue, 2 Apr 2002 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312888AbSDBSa2>; Tue, 2 Apr 2002 13:30:28 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:15014 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S312883AbSDBSaP>; Tue, 2 Apr 2002 13:30:15 -0500
Date: Tue, 2 Apr 2002 12:30:14 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200204021830.MAA24179@tomcat.admin.navo.hpc.mil>
To: mylinuxk@yahoo.ca, linux-kernel@vger.kernel.org
Subject: Re: Get major number in Makefile
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Zhu <mylinuxk@yahoo.ca>:
> 
> Hi, smart gurus, I have a question while writing a
> Makefile file to install my device driver. In my
> device driver I dynamically allocate the major number
> of my device. In my Makefile I want to build a device
> node for my device under the /dev directory.
> 
>    mknod /dev/mydevice c $major 0;
> 
> So I need to know the major number of my deivce in the
> Makefile. I've read the Linux 'Device Driver'. There
> is some information about this. I use the following
> command to get the major number in my Makefile.
> 
> major=`awk "\\$2==\"$mymodule\" {printf \\$1}"
> /proc/devices`
> 
> But when I use the 'make install' command to install
> my driver, the following error returned.
> 
> major=`awk "\\==\"$ymodule\" {printf \\}"
> /proc/devices`
> awk: 0: unexpected character '\'
> awk: line 1: syntax error at or near ==
> make: *** [install] Error 2
> 
> What is wrong with my command? Can anyone tell me how
> to get the major number in Makefile.

1. you want $(mymodule) instead of $mymodule
2. instead of \\$ you want $$
3. you need to use the @ construct.

vcs was the module I looked for.

Don't put quotes around it... that has make passing the quotes too.

End result is something like the following:

mymodule=vcs

target:
        @major=`awk '$$2 == "$(mymodule)" {print $$1}' /proc/devices`
        @echo $$major

Whether or not you really want to do this is something else. 

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
