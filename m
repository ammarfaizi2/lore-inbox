Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUHGLan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUHGLan (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 07:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUHGLan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 07:30:43 -0400
Received: from s-und-t-linnich.de ([217.160.180.132]:17792 "HELO
	s-und-t-linnich.de") by vger.kernel.org with SMTP id S261500AbUHGLa1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 07:30:27 -0400
Date: Sat, 7 Aug 2004 15:29:41 +0200
From: Sebastian <admin@wodkahexe.de>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MTRR problem, maybe FB related
Message-Id: <20040807152941.78ce8412.admin@wodkahexe.de>
In-Reply-To: <20040806203436.GA22421@redhat.com>
References: <20040806194722.6298b00f.admin@wodkahexe.de>
	<20040806203436.GA22421@redhat.com>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004 21:34:36 +0100
Dave Jones <davej@redhat.com> wrote:

> On Fri, Aug 06, 2004 at 07:47:22PM +0200, admin@wodkahexe.de wrote:
> 
>  > vesafb: framebuffer at 0xb0000000, mapped to 0xdf80d000, size 6144k
>  > vesafb: mode is 1024x768x32, linelength=4096, pages=4
> 
> vesafb's mtrr usage is borken. Instead of creating an MTRR the size
> of video RAM, it creates one the size of the display.
> 
>  > mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000
>  > [drm] Initialized i830 1.3.2 20021108 on minor 0: Intel Corp. 82852/855GM Integrated Graphics Device
>  > mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000
>  > [drm] Initialized i830 1.3.2 20021108 on minor 1: Intel Corp. 82852/855GM Integrated Graphics Device (#2)
> 
> Then X comes along, sizes the video ram, and tries to create an MTRR
> of the correct size, but the framebuffer got there first and bodged it.
> 
> I used to see this happening also on my Matrox g550, but it seems
> to have 'gone away' in recent times. I haven't checked out why,
> but I'm suspecting X now detects this case, and deletes the crap
> entry, and puts the proper values in its place.
> 
>  > when starting X i'm getting the following in dmesg:
>  > 
>  > mtrr: base(0xb0020000) is not aligned on a size(0x180000) boundary
> 
> This one I can't explain however.
> 
>  > mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000
>  > 
>  > is there any way to get both working together? (fb + mtrr)
> 
> Disable MTRR for vesafb. iirc, there's a boot command line option to do it.
> 
> 		Dave
> 

Ah, I see. It's not documented in Documentation/fb/vesafb.txt, but after
looking at drivers/video/vesafb.c i got it (video=vesafb:nomtrr).
Now it seems to work, but X still gives me upon starting:

mtrr: base(0xb0020000) is not aligned on a size(0x180000) boundary

thanks

sebastian
