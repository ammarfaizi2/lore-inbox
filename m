Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUHFUi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUHFUi3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268288AbUHFUh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:37:28 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:22665 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266170AbUHFUfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:35:50 -0400
Date: Fri, 6 Aug 2004 21:34:36 +0100
From: Dave Jones <davej@redhat.com>
To: "admin@wodkahexe.de" <admin@wodkahexe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MTRR problem, maybe FB related
Message-ID: <20040806203436.GA22421@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"admin@wodkahexe.de" <admin@wodkahexe.de>,
	linux-kernel@vger.kernel.org
References: <20040806194722.6298b00f.admin@wodkahexe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806194722.6298b00f.admin@wodkahexe.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 07:47:22PM +0200, admin@wodkahexe.de wrote:

 > vesafb: framebuffer at 0xb0000000, mapped to 0xdf80d000, size 6144k
 > vesafb: mode is 1024x768x32, linelength=4096, pages=4

vesafb's mtrr usage is borken. Instead of creating an MTRR the size
of video RAM, it creates one the size of the display.

 > mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000
 > [drm] Initialized i830 1.3.2 20021108 on minor 0: Intel Corp. 82852/855GM Integrated Graphics Device
 > mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000
 > [drm] Initialized i830 1.3.2 20021108 on minor 1: Intel Corp. 82852/855GM Integrated Graphics Device (#2)

Then X comes along, sizes the video ram, and tries to create an MTRR
of the correct size, but the framebuffer got there first and bodged it.

I used to see this happening also on my Matrox g550, but it seems
to have 'gone away' in recent times. I haven't checked out why,
but I'm suspecting X now detects this case, and deletes the crap
entry, and puts the proper values in its place.

 > when starting X i'm getting the following in dmesg:
 > 
 > mtrr: base(0xb0020000) is not aligned on a size(0x180000) boundary

This one I can't explain however.

 > mtrr: 0xb0000000,0x8000000 overlaps existing 0xb0000000,0x400000
 > 
 > is there any way to get both working together? (fb + mtrr)

Disable MTRR for vesafb. iirc, there's a boot command line option to do it.

		Dave

