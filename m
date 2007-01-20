Return-Path: <linux-kernel-owner+w=401wt.eu-S932617AbXATEPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbXATEPn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 23:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbXATEPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 23:15:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:39205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932617AbXATEPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 23:15:43 -0500
X-Authenticated: #5039886
Date: Sat, 20 Jan 2007 05:15:40 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       htejun@gmail.com, jens.axboe@oracle.com, lwalton@real.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070120041540.GA10407@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Robert Hancock <hancockr@shaw.ca>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
	htejun@gmail.com, jens.axboe@oracle.com, lwalton@real.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AC1DA3.5040104@shaw.ca> <45AC3006.9070705@garzik.org> <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45B18160.9020602@shaw.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.19 20:41:36 -0600, Robert Hancock wrote:
> Alistair John Strachan wrote:
> >On Tuesday 16 January 2007 01:53, Jeff Garzik wrote:
> >>Robert Hancock wrote:
> >>>I'll try your stress test when I get a chance, but I doubt I'll run into
> >>>the same problem and I haven't seen any similar reports. Perhaps it's
> >>>some kind of wierd timing issue or incompatibility between the
> >>>controller and that drive when running in ADMA mode? I seem to remember
> >>>various reports of issues with certain Maxtor drives and some nForce
> >>>SATA controllers under Windows at least..
> >>Just to eliminate things, has disabling ADMA been attempted?
> >>
> >>It can be disabled using the sata_nv.adma module parameter.
> >
> >Setting this option fixes the problem for me. I suggest that ADMA defaults 
> >off in 2.6.20, if there's still time to do that.
> >
> 
> Can you guys that are having this problem try the attached debug patch? 
> It's possible it will fix the problem, as I'm trying a private 
> exec_command implementation that flushes the write by reading a 
> controller register instead of reading altstatus from the drive like the 
> libata core code does.

Will give it a spin in about an hour.

> If the problem still happens, I also added some more debugging in to 
> help figure out what is going on, so please post full dmesg.
> 
> By the way, I assume that you guys are using reiserfs or xfs, as it 
> appears no other file systems issue flush commands automatically. I had 
> to test this by "echo 1 > delete" on the SCSI disk in sysfs, as I am 
> using ext3.

No, ext3 here, on top of md RAID1 and LVM. Oh, and one ext2, I wonder
where that comes from...

Björn
