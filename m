Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292447AbSBPRC1>; Sat, 16 Feb 2002 12:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292453AbSBPRCS>; Sat, 16 Feb 2002 12:02:18 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:5207 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S292447AbSBPRCB>; Sat, 16 Feb 2002 12:02:01 -0500
Date: Sat, 16 Feb 2002 19:01:43 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, jfr@viasys.com
Subject: VIA KT133 (was: Re: Quick question on Software RAID support.)
Message-ID: <20020216170143.GN1029@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Mark Cooke <mpc@star.sr.bham.ac.uk>, vojtech@suse.cz,
	linux-kernel@vger.kernel.org, jfr@viasys.com
In-Reply-To: <20020214001242.A14015@viasys.com> <Pine.LNX.4.44.0202152325020.11081-100000@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0202152325020.11081-100000@pc24.sr.bham.ac.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 11:48:41PM +0000, you [Mark Cooke] wrote:
> 
> Hi Ville,
> 
> I've just been trying this here, with the following setup, and it's 
> (so far) been reliable.... Just doing a 3rd pass..
> 
> hdc: seagate 80G, 1Gb partition (r5 parity)
> hde: seagate 40G, 1Gb partition (r5 data)
> hdg: seagate 40G, 1Gv partition (r5 data)

Hm, doesn't this mean that you can't read hde+hdg faster than hdc gives
parity data? That'd mean hde+hdg are not maxing out HPT and PCI channel...

You could perhaps run 2 separate wrchk's on hde and hdg (and one on hdc if
you please) - you can use it on file as well as on device.
 
> AGP currently disabled (NvAgp=0 in the Xserver config).
> 
> Running: ./w /dev/md2 2000 8 50

I have usually used ~64MB blocks¹, but I don't it matters.

¹) For those too lazy to read the source, wrchk args are [1] device 
   or file [2] test file size [3] read/write block size [4] num of
   iterations (0 for infinite test) ;).

>          ping -f s 64000

Is this RTL or 905B? We had better success with RTL8139 (but corruption
happened still), whereas with 3c905b would trigger corruption almost
instantly if it was attached to PCI slot 4. In slot 3, it behaved a lot
better, but the corruption eventually happened.

>          xawtv running for more traffic
>          mplayer divx playback
>          gears (for accel gl stressing)

Hmm, we never ran X at all.

>          xmms playing back mp3s
> 
> System's running pretty decently still (it's on pass 5 of the
> partition blasting).  Note however, that I currently have all the disk
> interfaces reset to only udma 3 as part of the startup scripts.  I'll
> pull out the exact pci-tweaking bios settings when I next restart.

Yep, I think the udma mode makes difference. Though we did try UDMA33, but
it didn't solve the problem for us.
 
> (though udma 3 is supposedly just shy of the maximum xfer rate the
> barracuda IV's can produce).

Better verify that with hdparm -tT...

> While doing this stress testing, I
> currently have no swapfile setup at all.

Neither did we. We usually lanched the kernel from boot floppy and had the
rootfs on cd. This way it wasn't possble to destruct anything while
testing...

>  Kernel's 2.4.18pre9-ac4 
> now, and the via tweaking in there might be a factor too.

We tried 2.2.20+ide, 2.2.21pre2+ide, 2.4.15, 2.4.18pre-something+ide etc. It
didn't make difference.
 

-- v --

v@iki.fi
