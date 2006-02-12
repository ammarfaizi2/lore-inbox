Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWBLBLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWBLBLO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 20:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWBLBLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 20:11:14 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:47054 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932085AbWBLBLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 20:11:13 -0500
Message-ID: <43EE8B20.7000602@cfl.rr.com>
Date: Sat, 11 Feb 2006 20:10:56 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: iSteve <isteve@rulez.cz>
CC: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver>
In-Reply-To: <20060211211440.3b9a4bf9@silver>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iSteve wrote:
> I used cdrecord (via xcdroast) to blank the CDRW and then burn UDF image created
> by mkudffs.
> 
> Can I get this mount rainer udf extension work using just this method, and then
> mount it?
> 
> Are there any specific mkudffs option that can help me? Or am I absolutely
> obliged to use cdrwtool if I want to even think about using packet writing or
> any other method to mount a CDRW?

cdrecord is just burning the image in dao/tao/sao mode.  To use pktcdvd 
to read/write the disc on the fly it must be formatted for packet mode 
using cdrwtool.  If the disc is formatted in MRW mode, then you don't 
even need pktcdvd to read/write it, that is supported by the firmware in 
the drive.  Right now I believe you can use the dvd-rwtools package to 
format media in MRW mode, and I plan on adding it as an option to 
cdrwtool at some point.  See http://fy.chalmers.se/~appro/linux/DVD+RW/ 
for more info.

The difference between packet mode and MRW mode is that MRW reserves 
some of the disc for bad sector sparing, and the drive firmware handles 
the reblocking rather than pktcdvd ( it also handles the sector 
remapping ).  Packet mode was around first and has wider support and 
requires less from the drive's firmware, but these days, it seems that 
the vast majority of drives support MRW.

I still have not figured out if MRW uses zero loss linking.  If it does, 
then that would probably make up for the space it reserves for sector 
sparing.  If it does not, then packet mode with > 32 sector packets will 
be more space efficient.  I have been planning on experimenting to see 
if it is possible to format the disc in packet mode with zero loss 
linking on some newer drives.  I believe that may be possible in which 
case, that will eliminate the space overhead associated with packet mode 
entirely.


