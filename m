Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313815AbSDIIGc>; Tue, 9 Apr 2002 04:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313820AbSDIIGb>; Tue, 9 Apr 2002 04:06:31 -0400
Received: from dsl-linz6-241-149.utaonline.at ([212.152.241.149]:19697 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S313815AbSDIIGa>;
	Tue, 9 Apr 2002 04:06:30 -0400
Message-ID: <3CB29DAD.DE763FEB@falke.mail>
Date: Tue, 09 Apr 2002 09:52:13 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: COMPILE BUG: SiS DRM Support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: thomas@winischhofer.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Is there any obvious reasons why this isn't compiling?
> > Try compiling with SiS framebuffer device (CONFIG_FB_SIS and
> > CONFIG_FB_SIS_300 or CONFIG_FB_SIS_315) activated... the SiS DRI driver
> > needs it... don't ask me why ;)
> 
> Because they share common code. It is actually better that they work
> together since this way they will not step on each others toes. Someday I
> plan to merge both the fbdev and drm interfaces together.

More precisely, the framebuffer driver contains all the chipset and
therefore the memory (amount/type) detection stuff. It checks for
eventual Turbo/Commandqueue capabilities (which differ significantly
depending on the actual chipset used) and sets up a memory heap taking
all the hardware specifics into account. Moving the memory management to
the DRM module will result in a lot of duplicate code and a lack of
common memory management.

If you don't want to use the framebuffer, start it with no video mode
specified or with mode=none (or mode:none if as kernel parameter)

Thomas

PS: For updates of the SiS VGA drivers, please check my homepage.

-- 
Thomas Winischhofer
Vienna/Austria                 
mailto:thomas@winischhofer.net            http://www.winischhofer.net/

