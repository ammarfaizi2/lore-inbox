Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264714AbTE1Mu5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbTE1Mu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:50:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59151 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264714AbTE1Mux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:50:53 -0400
Date: Wed, 28 May 2003 14:03:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: still no boot logo
Message-ID: <20030528140357.A5586@flint.arm.linux.org.uk>
Mail-Followup-To: Bob Tracy <rct@gherkin.frus.com>,
	linux-kernel@vger.kernel.org
References: <20030528125133.6C3C64F11@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030528125133.6C3C64F11@gherkin.frus.com>; from rct@gherkin.frus.com on Wed, May 28, 2003 at 07:51:33AM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 07:51:33AM -0500, Bob Tracy wrote:
> Yeah, it's minor compared to what *could* be (and probably is) broken.
> I've got "CONFIG_LOGO=y" and "CONFIG_LOGO_LINUX_CLUT224=y" with VESA
> framebuffer -- the same setup I've used successfully for many moons.
> 
> On the positive side, whatever broke in the 2.5.6X series that affected
> my DHCP server has been fixed: my HP network printer thanks you :-).
> Overall, 2.5.70 seems to be working fine for me other than the minor
> matter of the logo at boot time.

Someone (I forget who, because I've had the patch so long) sent me this
which fixes the problem for me.

--- orig/drivers/video/cfbimgblt.c	Mon May  5 17:39:49 2003
+++ linux/drivers/video/cfbimgblt.c	Tue May 13 23:53:23 2003
@@ -325,7 +325,7 @@
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
 					start_index, pitch_index);
-	} else if (image->depth == bpp) 
+	} else if (image->depth <= bpp) 
 		color_imageblit(image, p, dst1, start_index, pitch_index);
 }
 

Can whoever sent this please try to get James to accept the fix and
push it to Linus please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

