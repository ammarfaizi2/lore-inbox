Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbTDBRag>; Wed, 2 Apr 2003 12:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263076AbTDBRag>; Wed, 2 Apr 2003 12:30:36 -0500
Received: from ext-ch1gw-3.online-age.net ([216.34.191.37]:64706 "EHLO
	ext-ch1gw-3.online-age.net") by vger.kernel.org with ESMTP
	id <S263070AbTDBRad>; Wed, 2 Apr 2003 12:30:33 -0500
From: "Kiniger, Karl (MED)" <karl.kiniger@med.ge.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 2 Apr 2003 19:41:17 +0200
Subject: Re: how to interpret ide error messages (2.4)
Message-ID: <20030402174117.GA26195@ki_pc2.kretz.co.at>
References: <20030402122324.GA23847@ki_pc2.kretz.co.at> <1049290268.16275.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049290268.16275.51.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 02:31:09PM +0100, Alan Cox wrote:
> On Wed, 2003-04-02 at 13:23, Kiniger, Karl (MED) wrote:
> > kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > kernel: hdc: dma_intr: error=0x01 { AddrMarkNotFound }, LBAsect=20300322, sector=1263288
> > kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> The drive could not find the requested sector. That normally means bad
> things but for some drivers can also mean the controller asked for a
> totally bogon sector number
> 
> > kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=20803307, sector=1766272
> > kernel: end_request: I/O error, dev 16:04 (hdc), sector 1766272
> 
> Unrecoverable data error.
> 
> > The affected sectors dont generate any error messages if I read them today...
> 
> On errors the next write to a bad sector will typically remap it
> transparently to another spare block on the disk. Read obviously cannot
> do the same. That would mean that if for example clearcase ignored the
> I/O error and wrote back what it thought it saw but did not that it may
> have recovered the sector with invalid data. Its also possible of course
> clearcase actually handles I/O errors properly (which is hard).

What is giving me an alarm signal is:

Since it is a raid1 I expected user space not being affected.
(The other drive did not show any error messages since installation,
they are Maxtors 6Y120L0 (120 GB) cooled quite well) So I thought that
ClearCase should not have seen any error return code.

In the meantime I have just re-synced the faulty drive and there were
no write error messages and the bad block seems to be properly re-mapped

> 
> Consult the clearcase support I guess, there should be tools to verify
> your clearcase datasets. You might also want to force an fsck on your

fortunately only one replica packet seems to be corrupted and I can
request it again - the database seems ok after a run of the equivalent
of fsck.

> file systems while the box is down for disk replacement to check 
> everything out.

there is still interest what "sector=1766272" actually means, e.g given
a partition table and LBAsect, how to calculate 'sector' or vice versa.

Thanks,

Karl

-- 
Karl Kiniger        karl.kiniger@med.ge.com
GE Medical Kretztechnik
Tiefenbach 15
A-4871 Zipf         Tel: (++43) 7682-3800-710  Fax (++43) 7682-3800-47
