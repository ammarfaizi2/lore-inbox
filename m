Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSLONAN>; Sun, 15 Dec 2002 08:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSLONAN>; Sun, 15 Dec 2002 08:00:13 -0500
Received: from smtp.terra.es ([213.4.129.129]:60565 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id <S266527AbSLONAJ>;
	Sun, 15 Dec 2002 08:00:09 -0500
Message-ID: <002901c2a43a$b057d5c0$6e9afea9@anabel>
From: =?iso-8859-1?Q?David_San=E1n_Baena?= <davidsanan@teleline.es>
To: <linux-kernel@vger.kernel.org>
Subject: problems creating a driver
Date: Sun, 15 Dec 2002 14:05:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and before of all thank you for read this.

First I use kernel 2.4.9
I have made a driver to change data betwen kernel and user space.
but when compiling I got the following message:

[david@localhost samplepackage]# make
c++ -w -Wall -fno-exceptions -fno-rtti -fvtable-thunks -DHAVE_CONFIG_H -I. -
I. -I. -I/usr/local/include -I/usr/local/share/click/src -I/usr/src/linux/in
clude -MD -DCLICK_LINUXMODULE -DCLICK_PACKAGE -O2 -c totcl.cc -o totcl.ko
totcl.cc:60: sorry, not implemented: non-trivial labeled initializers
totcl.cc:60: cannot convert `ssize_t (*) (file *, char *, unsigned int,
loff_t *)' to `module *' in initialization
totcl.cc:60: sorry, not implemented: non-trivial labeled initializers
totcl.cc:60: cannot convert `int (*) (inode *, file *)' to `loff_t (*)
(file *, long long int, int)' in initialization
totcl.cc:60: sorry, not implemented: non-trivial labeled initializers
totcl.cc:60: cannot convert `int (*) (inode *, file *)' to `ssize_t (*)
(file *, char *, unsigned int, loff_t *)' in initialization
make: *** [totcl.ko] Error 1

my file_operations var is:
struct file_operations totcl_fops=
{
 read:totcl_read,
 open:totcl_open,
 release:totcl_release,
};

(I have seen this in many documents, even in linux files...)

when I removed the labels the "sorry, not implementd:non-trivial labeled
initializers" is not shown
And finally looking in "/usr/src/linux/include/linxu/fs.h"
I saw that with the first field is: module * own
so I have changed my file_operations var to:

static struct file_operations totcl_fops=
{            NULL,
              NULL, /*seek*/
 totcl_read,
              NULL,  /*write*/
              NULL, /* readdir*/
              NULL, /* select */
              NULL, /* ioctl */
              NULL, /*mmap*/
 totcl_open,
              NULL, /*fflush*/
 totcl_release
};
And now it compiles well... I have not test the result, but first I would
want to know why doesn't work the first declaration (when It must be work,
or not?).
Could I have any problems later because that?
Thanks In advance
David



