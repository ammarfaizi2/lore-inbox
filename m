Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWB1TAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWB1TAE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWB1TAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:00:01 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59928 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932415AbWB1TAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:00:01 -0500
Message-ID: <44049D5A.1010806@cfl.rr.com>
Date: Tue, 28 Feb 2006 13:58:34 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Sam Vilain <sam@vilain.net>, Luke-Jr <luke@dashjr.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works
 ;)
References: <200602250042.51677.bero@arklinux.org> <200602261330.15709.luke@dashjr.org> <9a8748490602260529h3a2890bhce4112feefb7cb1f@mail.gmail.com> <200602261339.13821.luke@dashjr.org> <Pine.LNX.4.61.0602262331330.12118@yvahk01.tjqt.qr> <440240F8.3010207@vilain.net <Pine.LNX.4.61.0602271946470.13987@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602271946470.13987@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2006 19:01:55.0375 (UTC) FILETIME=[71374BF0:01C63C99]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14295.000
X-TM-AS-Result: No--10.100000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Yes. A 650 MB *CD*-RW (DVD-RW too?) formatted in packet mode only has like
> 500-something megabytes to allow for the sort of seeks required.
> On DVD+RW, you get the full 4.3 GB (4.7 gB) AFAICS.
> 

DVD-RAM physically is formatted like a hard disk.  It is broken up into 
zones that hold different numbers of sectors which are individually and 
randomly read/writable.  CD/DVD+-RW media is organized as a single long 
groove that consists of an unbroken series of large blocks composed of 
small blocks with user and control data interleaved and error corrected. 
  It is for this reason that historically it could only be recorded from 
start to finish in one pass.

There are two modern techniques to allow pseudo random write access for 
all forms of CD/DVD +/- RW media.  These are packet mode, and mount 
rainier mode.  MRW mode formats the disk into 32 KB blocks made up of 
2048 byte sectors which are individually writable as far as the OS 
knows, because an MRW compliant drive is required to internally handle 
any required read/modify/write cycles to update the 32 KB blocks.  MRW 
mode also reserves some of the disk for sector sparing which the drive 
firmware also handles.  MRW mode is typically used on dvd+rw media. 
IIRC, this format typically "wastes" about 10% of the capacity of the 
medium.

The other technique is packet mode.  Packet mode formats the media into 
packets of sectors and each packet can be randomly rewritten.  The 
current default size is only 32 sectors per packet.  Each packet has 7 
sectors of linking loss so around 18% of the disk space is wasted.  I 
recently submitted a patch to pktcdvd and have some patches to the 
udftools package to support larger packet sizes.  A packet size of 128 
sectors reduces the waste to only 5.2%.

>> DVD+RW, on the other hand, I just thought was a different surface technology
>> (more expensive, higher quality) than DVD-RW.  There is nothing to help with
>> the lead-in/lead-out problem that is why you have several megabytes of lead-in
>> and lead-out per session on a multi-session disc.
>>
>> But maybe I'm wrong here... if I could use a DVD+RW like a DVD-RAM I'd be very
>> happy indeed.
>>
>> Sam.
>>
>>
> 
> Jan Engelhardt

