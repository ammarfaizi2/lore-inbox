Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267555AbRGMV5G>; Fri, 13 Jul 2001 17:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267556AbRGMV4z>; Fri, 13 Jul 2001 17:56:55 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:12817 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267555AbRGMV4o>; Fri, 13 Jul 2001 17:56:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: s-jaschke@t-online.de (Stefan Jaschke)
Reply-To: stefan@jaschke-net.de
Organization: jaschke-net.de
To: Luc Lalonde <llalonde@giref.ulaval.ca>
Subject: Re: Adaptec SCSI driver lockups
Date: Fri, 13 Jul 2001 23:55:10 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B4E14E4.BF0497@giref.ulaval.ca>
In-Reply-To: <3B4E14E4.BF0497@giref.ulaval.ca>
Cc: "lkml" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01071323551000.30655@antares>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 July 2001 23:21, Luc Lalonde wrote:
> Hello folks,
>
> I'm having trouble identifying wether I'm having hardware or software(
> OS ) problems.  For the past couple of Months I've been having system
> lockups every 10 days or so.

I had a similar problem with an Adaptec AHA-29160 (AIC-7892) when 
doing transfers from a SCSI DVD-drive to SCSI hard disk. It was actually 
very annoying since 
 - I did an update to SuSE 7.2
 - it almost destroyed my installation (several runs of e2fsck needed, some
    libs broken after the crash)
 - the SCSI bus hang appeared not immediatly, but after several minutes
   of activity.
I tried:
(1) to load aic7xxx_old (see
 http://sdb.suse.de/de/sdb/html/ostoelt_aic7xxx_old.html) -> crashed also.
(2) I tried to disable tagged command queuing or set "tag_info" to 
 more moderate values since I noticed that the queue length was set 
 to an incredible length of 253. However, the new driver from Adaptec 
 just ignores the old kernel parameters.
(3) According to an SDB article
 (http://sdb.suse.de/de/sdb/html/jsj_29160_interrupt.html),
 I manually set all PCI slots to different interrupts (but I could not set
 the interrupt of the graphics card). -> crashed also
(4) I finally managed to get a workable system again by booting with a 2.2.x
 kernel (SuSE 7.1), copying the DVD to a hard disk and then install from the
 hard disk. 
(5) I compiled a custom kernel and set the queue length parameter to 8. The
 system now appears to be stable with the new (!) driver.
 
My guess is: the new driver stresses the hardware more than the old driver.
And it may at least partly be a hardware problem involving slow devices.
(The same configuration that consistently crashed my DVD->HD transfers did 
not crash in an hour of very heavy HD->HD transfers.)

And here is a hint for the developers. Before the driver went into an endless
loop of SCSI bus resets, it said something like "locking queue length to 64
for device 0:0:0" (the HD that the data was copied to).
   
Hope this helps,
Stefan J.

-- 
Stefan R. Jaschke <stefan@jaschke-net.de>
http://www.jaschke-net.de
