Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWBSAlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWBSAlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 19:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWBSAlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 19:41:23 -0500
Received: from smtp.enter.net ([216.193.128.24]:3844 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S964773AbWBSAlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 19:41:22 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Sat, 18 Feb 2006 19:41:38 -0500
User-Agent: KMail/1.8.1
Cc: Christoph Hellwig <hch@infradead.org>, Bill Davidsen <davidsen@tmr.com>,
       Daniel Barkalow <barkalow@iabervon.org>, Greg KH <greg@kroah.com>,
       Nix <nix@esperi.org.uk>, Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <20060218120617.GA911@infradead.org> <200602181215.30277.gene.heskett@verizon.net>
In-Reply-To: <200602181215.30277.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602181941.40093.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 12:15, Gene Heskett wrote:
> On Saturday 18 February 2006 07:06, Christoph Hellwig wrote:
>
> cat /proc/sys/dev/cdrom/info
> CD-ROM information, Id: cdrom.c 3.20 2003/12/17
>
> drive name:             hdc
> drive speed:            48
> drive # of slots:       1
> Can close tray:         1
> Can open tray:          1
> Can lock tray:          1
> Can change speed:       1
> Can select disk:        0
> Can read multisession:  1
> Can read MCN:           1
> Reports media changed:  1
> Can play audio:         1
> Can write CD-R:         1
> Can write CD-RW:        1
> Can read DVD:           1
> Can write DVD-R:        1
> Can write DVD-RAM:      0
> Can read MRW:           1
> Can write MRW:          1
> Can write RAM:          1

Ah, so it does already exist. Only thing left might be to stick the 
manufacturer, serial and misc. data into sysfs

> But I fail to see where this would help to 'find' the right device to
> write to, other than the obvious prefixing of '/dev/' to $drive name.
> We already knew that, and in fact it works very well. Please explain to
> Joerg in one syllable words he might, if he wanted to, understand.

Well, in this case I'm actually trying to work with Joerg to produce a patch 
that unifies the ATAPI and SCSI busses inside his program. One thing this 
does is help to locate available drives. Negates the need to scan the entire 
ATA/ATAPI bus for drives. However, since, as Joerg has pointed out, libscg is 
a generic SCSI system, it doesn't negate it's need to scan the entire SCSI 
bus. It's use as a backend to cdrecord is incidental in this case.

> Also, I'm fuzzy about the last 3, so defining those might help me
> understand.

I've seen the "MRW" stuff in some of the specs, but had to check the net to 
find out what it was. MRW is the Mt. Rainier format - basic support was added 
by Jens back in 2.4.19 according to the archives. 
(http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/1214.html)

I'm not positive, but the "Can Read RAM" line might refer to DVD-RAM type 
discs

DRH
