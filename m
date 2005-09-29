Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbVI2Bhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVI2Bhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVI2Bhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:37:38 -0400
Received: from drizzle.cc.mcgill.ca ([132.206.27.48]:32407 "EHLO
	drizzle.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S1751303AbVI2Bhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:37:38 -0400
Subject: RE: problem with 2.6.13.[0-2]
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Reply-To: David.Ronis@mcgill.ca
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: david.ronis@mcgill.ca, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.WNT.4.63.0509272247550.2588@home-comp>
References: <Pine.WNT.4.63.0509272247550.2588@home-comp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Chemistry, McGill University
Date: Wed, 28 Sep 2005 21:37:10 -0400
Message-Id: <1127957830.6261.5.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 22:55 -0400, Parag Warudkar wrote:
> 
> > DMA is on in both 2.6.12.6 and in 2.6.13.2.  Here's what hdparm
> > /dev/hda gives:
> >
> > in 2.6.12.6:
> >
> > /dev/hda:
> >  multcount    = 16 (on)
> >  IO_support   =  0 (default 16-bit)
> >  unmaskirq    =  0 (off)
> >  using_dma    =  1 (on)
> >  keepsettings =  0 (off)
> >  readonly     =  0 (off)
> >  readahead    = 256 (on)
> >  geometry     = 65535/16/63, sectors = 195371568, start = 0
> >
> > in 2.6.13.2 it's the same, except for
> >
> > multcount    =  0 (off)
> >
> > Could this be the problem, and if so, would setting multcount to on
> > fix it? (I take it hdparm -m 16 /dev/hda would do it)
> 
> I doubt if multcount will make a difference, but you can try.
> Probably next best thing to do is profile the slow kernel to find where it 
> is spending time. (pass profile=2 on kernel command line and use 
> readprofile or use oprofile).
> 
> Did you try hdparm -tT /dev/hda? It's going to be slow, thats for sure 
> from what you described but try that and then post dmesg (for both 
> kernels) and profile results - may be someone will get a clue from that.
> 
> Parag
> 
> 

Hi Parag,

Here's what I get:

In 2.6.12.6:

/dev/hda:
 Timing cached reads:   1140 MB in  2.00 seconds = 569.80 MB/sec
 Timing buffered disk reads:  102 MB in  3.02 seconds =  33.80 MB/sec

In 2.6.13.2:

/dev/hda:
 Timing cached reads:    28 MB in  2.15 seconds =  13.03 MB/sec
 Timing buffered disk reads:   14 MB in  3.30 seconds =   4.24 MB/sec

and after hdparm -m 16 /dev/hda (recall this is the default in 2.6.12.6)

/dev/hda:
 Timing cached reads:    24 MB in  2.05 seconds =  11.73 MB/sec
 Timing buffered disk reads:   36 MB in  3.11 seconds =  11.56 MB/sec

I ran thing a few times in each case and the results were close.  There
was nothing in dmesg.

David


