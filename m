Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSIILsq>; Mon, 9 Sep 2002 07:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317117AbSIILsq>; Mon, 9 Sep 2002 07:48:46 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:51590 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317112AbSIILsp>;
	Mon, 9 Sep 2002 07:48:45 -0400
Date: Mon, 9 Sep 2002 13:53:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE write speed (Promise versus AMD)
Message-ID: <20020909135325.A1125@ucw.cz>
References: <20020904195729.A3985@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020904195729.A3985@fi.muni.cz>; from kas@informatics.muni.cz on Wed, Sep 04, 2002 at 07:57:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 07:57:29PM +0200, Jan Kasprzak wrote:
> 	Hello, all!
> 
> 	I have a machine with six identical IDE drives (WD1200BB),
> three of them connected to the on-board controller (it is AMD 768MPX chipset),
> and other three are connected to the Promise controller (PDC 20269).
> All drives are UDMA 100, read speed measured by "hdparm -t /dev/hd[abcefg]"
> is about 45 MBytes/s for every drive. However, the write speed seems
> to differ between AMD and Promise controllers. I've tried to do
> 
> time sh -c 'dd if=/dev/zero of=/dev/hdX bs=1024k count=2048; sync'
> 
> - it takes about 50 seconds (~40 MByte/s write speed) on hda, hdb and hdc,
> but 2 minutes 48 seconds (~12 MByte/s write speed) on hde, hdf and hdg.
> I have 1 GB of RAM, server is dual athlon 2000+. Kernel is 2.4.20-pre5-ac1.
> 
> 	Is there any problem with the Promise IDE driver on Linux?

This looks most likely to be incorrect programming of UDMA registers on
the Promise chip. UDMA is asymmetrical by design - the hd->mb and mb->hd
speeds can be different. If you get correct read rates, it's the
harddrive that's set up correctly, for writes it's the IDE chip that has
to be programmed for the speed.

-- 
Vojtech Pavlik
SuSE Labs
