Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTJ3FU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 00:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTJ3FU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 00:20:58 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:28427 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S262074AbTJ3FU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 00:20:57 -0500
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: kronos@kronoz.cjb.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Javier Villavicencio <jvillavicencio@arnet.com.ar>
In-Reply-To: <20031029210321.GA11437@dreamland.darkstar.lan>
References: <20031029210321.GA11437@dreamland.darkstar.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 30 Oct 2003 00:20:34 -0500
Message-Id: <1067491238.1735.4.camel@ktkhome>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-29 at 16:03, Kronos wrote:
> > have been using ATI's private DRI/DRM kernel module driver (fglrx) in 
> > concert with XFree 4.2.0 for quite some time.
> 
> Ah! ATI's driver touches registers behind our back. Can you reproduce
> without this binary module?

Hi Luca, et al,

Yes, I can reproduce without the tainting kernel module (fglrx.o). 
Debugging a bit, the corruption shows up when using ATI's "fglr" device
driver in XF86Config.  If I switch to using the unaccelerated "Radeon"
driver provided by XFree, then the screen remains readable upon return
from X.  Thus, the kernel module is OK, the ATI proprietary glx and dri
modules are OK, it's just the driver.

However, I still think this belongs as a kernel issue, because it
appears to be a failing of the radeonfb.o module to properly set the
radeon registers.  Remember that version 0.1.4 of the driver does not
have this issue; it works just fine with the ATI fglr X driver.

Kris

