Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbRESL6Y>; Sat, 19 May 2001 07:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261775AbRESL6P>; Sat, 19 May 2001 07:58:15 -0400
Received: from pop.gmx.net ([194.221.183.20]:21298 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261773AbRESL6H>;
	Sat, 19 May 2001 07:58:07 -0400
Message-ID: <3B066184.5A6FA728@gmx.at>
Date: Sat, 19 May 2001 14:05:24 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VIA/PDC/Athlon - IDE error theory
In-Reply-To: <E150VHJ-0006Ak-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> 
> CRC errors are cable errors so that bit is reasonable in itself

Could this be caused by the RAID configuration? The first sector of the
first disk holds the partition table. The other disks in the raid have
no valid partition table:

dmesg message from Jussi Laako:
 hdf: unknown partition table
 hdg: unknown partition table
 hdh: unknown partition table
[snip]

If there is a raid (1+)0 configured you got a volume that is bigger than
the first hd. So if you have extended partitions or freebsd slices which
are located beyond the capacity of the hd, then the partition table
check would have to read datastructures which have an offset which is to
high. => read error during partition check => nasty error messages

I have the error message problem on my box. DMA is disabled because of
the error on /dev/hda. But a hdparm -d 1 /dev/hda fixes this, and I do
not get more errors regarding that. Everything works fine. (I did not
compile with Athlon optimization.)

regards,
Wilfried
