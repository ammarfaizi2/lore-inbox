Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSEXF4g>; Fri, 24 May 2002 01:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317092AbSEXF4f>; Fri, 24 May 2002 01:56:35 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:19110 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317091AbSEXF4f>;
	Fri, 24 May 2002 01:56:35 -0400
Date: Fri, 24 May 2002 07:56:34 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020524075634.A28157@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com> <3CED004A.6000109@evision-ventures.com> <20020523234720.A7495@bouton.inet6-interne.fr> <20020524005525.H27005@ucw.cz> <20020524022351.A8230@bouton.inet6-interne.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 02:23:51AM +0200, Lionel Bouton wrote:
> On Fri, May 24, 2002 at 12:55:25AM +0200, Vojtech Pavlik wrote:
> > 
> > If you rewrite the whole drive with zeros (or the original data) sector
> > by sector, the uncorrectable errors will go away. I've done this to my
> > 307030 and it works fine again. (Fortunately for me the errors were only
> > in my swap partition).
> > 
> 
> Don't know for the whole drive yet (currently running) but when I did a mkraid
> on a raid5 array using 4 partitions on the same drive the sync thread ended
> and left the array in degraded mode after a bunch of :
> May 24 02:05:06 twins kernel: hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> May 24 02:05:06 twins kernel: hdd: dma_intr: error=0x40 { UncorrectableError }, LBA sect=2097375, sector=2097298
> May 24 02:05:06 twins kernel: end_request: I/O error, dev 16:41 (hdd), sector 2097298
> 
> Then I tried to zero the offending sectors with a slight margin :
> [root@twins root]# dd if=/dev/zero of=/dev/hdd1 count=200 bs=512 seek=2097200
> dd: writing /dev/hdd1': Erreur d'entrée/sortie
> 113+0 enregistrements lus.
> 112+0 enregistrements écrits.
> 
> Same error each time, seems sector 2097312 is not my friend.
> 
> dd if=/dev/zero of=/dev/hdd bs=<cylinder_size> running.
> 
> Too bad lsof doesn't show offsets...
> I can't tell if dd passed the offending sector :-|

Well, if writing failed, it means the drive has ran out of relocatable
sectors. That's too bad ... best to send it in for replacement.

-- 
Vojtech Pavlik
SuSE Labs
