Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSEWWpx>; Thu, 23 May 2002 18:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317038AbSEWWpw>; Thu, 23 May 2002 18:45:52 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:45474 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317037AbSEWWpv>;
	Thu, 23 May 2002 18:45:51 -0400
Date: Fri, 24 May 2002 00:45:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "Gryaznova E." <grev@namesys.botik.ru>, martin@dalecki.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: IDE problem: linux-2.5.17
Message-ID: <20020524004546.E27005@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 04:27:39PM +0200, Martin Dalecki wrote:
> 
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> 
> Since this error can be expected to be quite common.
> Its an installation error. I will just make the corresponding
> error message more intelliglible to the average user:
> 
> hda: checksum error on data transfer occurred!
> 
> Would have hinted you propably directly at what's wrong.

There is a routine in the IDE code to decrease transfer speed in case of
these problems. And it is there for a good reason - many (namely UDMA66)
mainboards have incorrectly wired IDE traces and can never achieve full
UDMA speeds, and there is no way to know.

For that I've also created UDMA_SLOW, which is even slower than UDMA_0
(16.6 MB/sec), which still has CRC protection, and needs even less
physical bandwidth than PIO4.

-- 
Vojtech Pavlik
SuSE Labs
