Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRDSVcf>; Thu, 19 Apr 2001 17:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135716AbRDSVcZ>; Thu, 19 Apr 2001 17:32:25 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:10761 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131275AbRDSVcJ> convert rfc822-to-8bit; Thu, 19 Apr 2001 17:32:09 -0400
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Jens Axboe <axboe@suse.de>
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Date: Thu, 19 Apr 2001 23:11:31 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01041714250400.01376@antares> <01041914440701.01232@antares> <20010419150332.B22159@suse.de>
In-Reply-To: <20010419150332.B22159@suse.de>
MIME-Version: 1.0
Message-Id: <01041923113102.01232@antares>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 April 2001 15:03, Jens Axboe wrote:
> On Thu, Apr 19 2001, Stefan Jaschke wrote:
> > OK. I'll check again with 2.4.4-pre4+patches:
> > (1) Mounting the SuSE DVD-ROM (-t iso9660) from /dev/hdc on /dvd and
> >     reading from /dvd works. Same for CD-ROMs. I don't have a formatted
> >     DVD-RAM.
> > (2) Reading with "dd if=/dev/hdc ..."
> >    (2.1) works with CD-ROM inserted
> >    (2.2) fails with DVD-ROM inserted
>
> dd fails with DVD-ROM inserted??? In the same way? Is this the SuSE DVD,
> and not a movie DVD? Also, check dmesg for errors.
> >    (2.3) fails with DVD-RAM inserted

"dd if=/dev/hdc of=/dev/null bs=2k count=3" produces the same strace, whether
the DVD-RAM or the SuSE DVD-ROM is inserted. I interpret the fact that the
first read() returns 0 as some lower layer coming to the conclusion that
"/dev/hdc" has length 0. 
The only line that appears in the system logs is
  "VFS: Disk change detected on device ide1(22,0)"
when I change the disks.

> > (3) Writing with "dd of=/dev/hdc ..." works (with DVD-RAM inserted).
> > (4) "mke2fs -b 2048 /dev/hdc" fails (with DVD-RAM inserted).
I took a closer look at the strace of the "mke2fs ...". The first system call
that fails is
old_mmap(NULL, 504938496, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = -1 ENOMEM
It asks for 481MB, which I simply don't have. (128MB RAM,  256MB swap).
So, this may be unrelated to the kernel, just a quirk of mke2fs to ask for
that much memory.

> Could be, try
> cat /proc/ide/hdc/capacity
0                  (with empty tray)
8946816       (with single-sided 4.7GB DVD-RAM)
4875840       (with single-sided 2.6GB DVD-RAM)
9106700       (with SuSE DVD-ROM)
1325240       (with SuSE CD-ROM)

Seem to be 512 Byte blocks. Looks OK.

> And lets stick to hardware for now, ok? :-)
This means "There is hope to get the drive working under Linux"?

Correct me if I am wrong in my interpretations.

There are two mysteries (for me at least) left:
(1) Why does mke2fs need 481MB memory?
(2) Why does the very first read() on /dev/hdc return EOF?

What would you suggest to try next?

Stefan

