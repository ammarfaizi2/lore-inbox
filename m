Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129546AbRBXSwh>; Sat, 24 Feb 2001 13:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129553AbRBXSwS>; Sat, 24 Feb 2001 13:52:18 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:18703 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129546AbRBXSwN>;
	Sat, 24 Feb 2001 13:52:13 -0500
From: thunder7@xs4all.nl
Date: Sat, 24 Feb 2001 17:24:48 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: reiserfs: still problems with tail conversion
Message-ID: <20010224172448.A3125@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl> <Pine.LNX.4.30.0102241613140.1185-100000@sjoerd.sjoerdnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.30.0102241613140.1185-100000@sjoerd.sjoerdnet>; from iafilius@xs4all.nl on Sat, Feb 24, 2001 at 04:45:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001 at 04:45:04PM +0100, Arjan Filius wrote:
> Hello,
> 
> I tried Erik's trigger-program.
> 
> After some test i thing it's memory related, and it seems to match the
> other reports i saw on lkm.
> With my 384M ram i was not able te reproduce it.
> With "mem=32M" linux hang while starting a test oracle-db.
> However i tried (not repeated tests, and after a fresh reboot):
> ram=128M	; Triggered
> ram=138M	; Triggered
> ram=180M	; Triggered
> ram=192M	; NOT Triggered
> ram=250M	; NOT Triggered
> ram=256M	; NOT Triggered
> 
> These results say that it memory dependent, and perhaps memory use
> dependent.
> With the mem=180M i did some additional tests:
> 
> reisertest	; triggered
> free		; shows only 60M on cached data and 8192 files*8192
> 		  bytes=64M
> /sbin/swapout 100M	; make sure enough cache to hold 64M data
> reisertest	; NOT Triggered !!!!
> While leaving the data, and executing reisertest in a new dir i'm
> triggring it again!
> 
> So i think i can say, it's triggerable when the cache has no space to hold
> all the data (64M), but i didn't extensive tests.
> 
I can't confirm that. This machine has 512 Mb memory:

free
             total       used       free     shared    buffers     cached
Mem:        512940     144916     368024          0      12052     106552
-/+ buffers/cache:      26312     486628
Swap:      1992052          0    1992052

<after the failing test>
             total       used       free     shared    buffers     cached
Mem:        512940     144924     368016          0      12052     106552
-/+ buffers/cache:      26320     486620
Swap:      1992052          0    1992052

Jurriaan
-- 
BOFH excuse #167:

excessive collisions & not enough packet ambulances
GNU/Linux 2.4.2-ac3 SMP/ReiserFS 2x1730 bogomips load av: 0.26 0.06 0.02
