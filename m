Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVH1SIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVH1SIW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 14:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVH1SIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 14:08:22 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38097 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750730AbVH1SIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 14:08:21 -0400
Date: Sun, 28 Aug 2005 11:08:02 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Marineau <marineam@engr.orst.edu>
Cc: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Radeon acpi vgapost
Message-ID: <20050828180802.GB4209@us.ibm.com>
References: <43111298.80507@engr.orst.edu> <20050828051225.GA4225@us.ibm.com> <43116B45.1030702@engr.orst.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <43116B45.1030702@engr.orst.edu>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 28.08.2005 [00:44:05 -0700], Michael Marineau wrote:
> Nishanth Aravamudan wrote:
> > On 27.08.2005 [18:25:44 -0700], Michael Marineau wrote:
> > 
> >>Thses patches resume ATI radeon cards from acpi S3 suspend when using
> >>radeonfb by reposting the video bios. This is needed to be able to use
> >>S3 when the framebuffer is enabled.
> > 
> > 
> > Just wanted to report that these patches lead to progress on my T41p;
> > relevant lspci -vvv:
> > 
> > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc M10 NT [FireGL Mobility T2] (rev 80) (prog-if 00 [VGA])
> > 	Subsystem: IBM: Unknown device 054f
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B+
> > 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > 	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
> > 	Interrupt: pin A routed to IRQ 11
> > 	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
> > 	Region 1: I/O ports at 3000 [size=256]
> > 	Region 2: Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
> > 	Capabilities: <available only to root>
> > 
> > In 2.6.13-rc7 or 2.6.13-rc6-mm2, after echo mem > /sys/power/state, the
> > lcd light comes back, but no video is actually displayed (I just notice
> > that the backlight turns on). With your patches, I now see (with either
> > rc7 or rc6-mm2) a mostly black screen with "inux" in the upper left --
> > basically a garbled console -- which slowly turns completely white.
> 
> I've seen the "inux" thing in the past, but by pressing a key shortly
> after the screen turns back on the system continued to resume as usual.
>  Given that the backlight normally turns back on for you maybe this post
> method isn't the correct solution for your card. Mine wouldn't even turn
> on the backlight.

Oh ok, thanks. I tried the keypress and nothing happened.

> > 
> > If you would like me to do more debugging, I would be more than happy to
> > do so.
> 
> What is the behaviour when the framebuffer is not enabled? If in that
> case it doesn't work out of the box, does it work with a userspace trick
> like vbetool?

It definitely doesn't work OOB for me. I didn't know about vbetool
before (I have messed with radeontool, though, when I told BenH about
this problem a while ago).

Here is what I ended up with in my lidbtn.sh (when I wish to
sleep-to-mem):

chvt 1 //vbetool needs to run from text console
echo mem > /sys/power/state
vbetool post //brings back video mode correctly
chvt 7 //return to X

This seems to work, if the framebuffer is not enabled.

radeontool's regs argument provides some useful information, I think. I
have attache three files, radeontool.pre, radeontool.post and
radeontool.postpost, which capture the output of radeontool regs before
the suspend, after the suspend and after the vbetool command
respectively. As you can see, there is a significant difference between
.pre and .post and less of one between .pre and .postpost.

Perhaps also useful, I have attached the equivalent output with the fb
enabled, in radeontool.fb.pre, radeontool.fb.post and
radeontool.fb.postpost.

Thanks,
Nish

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeontool.pre"

RADEON_DAC_CNTL=ff000002
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=07770142
RADEON_DISP_OUTPUT_CNTL=1000000a
RADEON_CONFIG_MEMSIZE=08000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=0f000000
RADEON_CRTC_GEN_CNTL=02000200
RADEON_CRTC2_GEN_CNTL=00800000
RADEON_DEVICE_ID=00004e54
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000000
RADEON_GPIO_CRT2_DDC=00000000
RADEON_GPIO_DVI_DDC=00000300
RADEON_GPIO_VGA_DDC=00000300
RADEON_LVDS_GEN_CNTL=003cffa1

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeontool.post"

RADEON_DAC_CNTL=ff000002
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=00770103
RADEON_DISP_OUTPUT_CNTL=1000000a
RADEON_CONFIG_MEMSIZE=08000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=0f000000
RADEON_CRTC_GEN_CNTL=02000200
RADEON_CRTC2_GEN_CNTL=02000000
RADEON_DEVICE_ID=00004e54
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000000
RADEON_GPIO_CRT2_DDC=00000000
RADEON_GPIO_DVI_DDC=00000300
RADEON_GPIO_VGA_DDC=00000300
RADEON_LVDS_GEN_CNTL=08000008

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeontool.postpost"

RADEON_DAC_CNTL=ff000002
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=07770142
RADEON_DISP_OUTPUT_CNTL=1000000a
RADEON_CONFIG_MEMSIZE=08000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=00000000
RADEON_CRTC_GEN_CNTL=02000200
RADEON_CRTC2_GEN_CNTL=00800000
RADEON_DEVICE_ID=00004e54
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000000
RADEON_GPIO_CRT2_DDC=00000000
RADEON_GPIO_DVI_DDC=00000300
RADEON_GPIO_VGA_DDC=00000300
RADEON_LVDS_GEN_CNTL=003cffa1

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeontool.fb.pre"

RADEON_DAC_CNTL=ff002102
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=07770142
RADEON_DISP_OUTPUT_CNTL=1000000a
RADEON_CONFIG_MEMSIZE=08000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=0d000048
RADEON_CRTC_GEN_CNTL=03000200
RADEON_CRTC2_GEN_CNTL=00800000
RADEON_DEVICE_ID=00004e54
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000000
RADEON_GPIO_CRT2_DDC=00000000
RADEON_GPIO_DVI_DDC=00000300
RADEON_GPIO_VGA_DDC=00000300
RADEON_LVDS_GEN_CNTL=003cffa1

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeontool.fb.post"

RADEON_DAC_CNTL=ff002102
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=00770103
RADEON_DISP_OUTPUT_CNTL=1000000a
RADEON_CONFIG_MEMSIZE=08000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=00000048
RADEON_CRTC_GEN_CNTL=03000200
RADEON_CRTC2_GEN_CNTL=02000000
RADEON_DEVICE_ID=00004e54
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000000
RADEON_GPIO_CRT2_DDC=00000000
RADEON_GPIO_DVI_DDC=00000300
RADEON_GPIO_VGA_DDC=00000300
RADEON_LVDS_GEN_CNTL=080c0089

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="radeontool.fb.postpost"

RADEON_DAC_CNTL=ff000002
RADEON_DAC_CNTL2=00000000
RADEON_TV_DAC_CNTL=07770142
RADEON_DISP_OUTPUT_CNTL=1000000a
RADEON_CONFIG_MEMSIZE=08000000
RADEON_AUX_SC_CNTL=00000000
RADEON_CRTC_EXT_CNTL=00000000
RADEON_CRTC_GEN_CNTL=02000200
RADEON_CRTC2_GEN_CNTL=00800000
RADEON_DEVICE_ID=00004e54
RADEON_DISP_MISC_CNTL=5b300600
RADEON_GPIO_MONID=00000000
RADEON_GPIO_MONIDB=00000000
RADEON_GPIO_CRT2_DDC=00000000
RADEON_GPIO_DVI_DDC=00000300
RADEON_GPIO_VGA_DDC=00000300
RADEON_LVDS_GEN_CNTL=003cffa1

--ibTvN161/egqYuK8--
