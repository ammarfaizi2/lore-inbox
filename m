Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbTBUO7v>; Fri, 21 Feb 2003 09:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTBUO7v>; Fri, 21 Feb 2003 09:59:51 -0500
Received: from mail.zmailer.org ([62.240.94.4]:40361 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267473AbTBUO7s>;
	Fri, 21 Feb 2003 09:59:48 -0500
Date: Fri, 21 Feb 2003 17:09:53 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: The linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Genericish floppy-driver problem ? (2.4/2.5)
Message-ID: <20030221150953.GK1073@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my Dell Laptop, I have a 3.5" diskette driver plugin, which
works fine, when I do normal things, but earlier this week I had
a "mystery diskette" to decode, and pull data out.

The diskette in question was written in a "DD" driver, but used
media was of "HD" type.  The end result was that its format was
"wrong" for the media, and reading it failed.
A quick transformation of a "HD" diskette into a "DD" type is
explained at site:

   http://fdutils.linux.lu/disk-id.html

where there are also many tests to discover things about the diskette data 
format.   To read the "DD format in HD media" diskette successfully, 
"rate=2" parameter was necessary in tests done in that page to determine
various parameters of the diskette.
(That is, a "taped-up-DD" media is formatted into 720 kB capacity, and
 then the tape is removed getting a "DD in disguise" media format)


While using that utility with 2.4.20-redhat-rawhide-xyz kernel,
and following the instructions to determine what the data really
is in there, execution of command:

  fdrawcmd read 0  1 0 1 2  0 0x1b 0xff length=10240 need_seek track=1 >/dev/null

did cause the floppy driver to yield some kernel error dump, and
any floppy command after that did return EXIO error.  Only reboot
restored the driver back to sanity.

A sticky error state is, of course, considerable as a bug in this case.
Is this really worth the effort to fix ?  I am not sure.

The Floppy driver (drivers/block/floppy.c) does not appear to have
listed MAINTAINER, but many people have touched on it over the years.

/Matti Aarnio
