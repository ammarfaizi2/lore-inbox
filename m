Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVBOMvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVBOMvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 07:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVBOMvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 07:51:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:53638 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261705AbVBOMvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 07:51:33 -0500
Subject: Re: Radeon FB troubles with recent kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vincent C Jones <vcjones@networkingunlimited.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mpm@selenic.com
In-Reply-To: <20050215031441.EFABE1DDFE@X31.nui.nul>
References: <20050215031441.EFABE1DDFE@X31.nui.nul>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 23:50:46 +1100
Message-Id: <1108471847.10281.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On my Thinkpad X31 with a Radeon Mobility M6 LY I see a major
> regression going from 2.6.11-rc3 to rc4. With rc-4, the frame
> buffer console (using "video=radeonfb:1024x768-24@60") comes up as
> 640x480 expanded to 1024x768. The inability of ACPI suspend to turn
> off the backlight also returns. Using rc-3, frame buffer console
> works fine and suspend/resume appears to work reliably without
> needing radeontool to turn off the backlight (as long as I do it
> from X.org X).

Ok, this is getting complicated. So far, I'm getting a bit more success
reports that regression reports, so I'm keen to keep this new radeonfb
for 2.6.11...

There are several issues involved

As far as the mode setting is concerned, I'm not sure what's going on
whith your specific model, could you please enable radeonfb debug output
in the kernel config and send me the complete dmesg log ?

As far as the panel blanking is concerned (either during suspend or
normal console blanking), this is a tricky matter. It seems that a bit
of code that works for some panels won't work with others. So far, I
managed to isolate the issue to some panels relying on an inverted
signal out of the chip. I'm in contact with ATI to try to solve that
problem, it might be possible to get proper infos about the type of
panel connected via the BIOS ROM image. Unfortunately, I don't think
I'll get a definitive answer before 2.6.11 is released.

Note that some users have successfully enabled the powerbook/ibook
specific power management code I have in there for thinkpads. I intend t
o merge some of that stuff after 2.6.11 is done.

Ben.


