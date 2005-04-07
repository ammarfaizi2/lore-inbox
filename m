Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVDGLtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDGLtl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVDGLtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:49:41 -0400
Received: from mail.zmailer.org ([62.78.96.67]:944 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261328AbVDGLte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:49:34 -0400
Date: Thu, 7 Apr 2005 14:49:33 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk tree] DRM add a version check.. for 2.6.12 (distro kernel maintainers + drm users plz read also...)
Message-ID: <20050407114933.GH3858@mea-ext.zmailer.org>
References: <Pine.LNX.4.58.0503281236330.27073@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503281236330.27073@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping Linus off this list...

On Mon, Mar 28, 2005 at 12:40:16PM +0100, Dave Airlie wrote:
> Hi Linus,
> 
> In order to stop someone loading a drm driver on a wrong core this patch
> makes the driver pass in the version is was built against, this mainly
> useful for people using the DRI snapshots for cards that aren't their
> normal cards...
> 
> Also for anyone who maintains a kernel for distros or builds their own
> please build your kernels with CONFIG_DRM=m not =y, from 2.6.11 onwards..
> as if you build with =y then DRI snapshots will no longer work..

I tried 2.6.12-rc2 which includes this patch, and I get DRM failures
here, which causes application and X to hang.  (I got failures with 2.6.11
also.) 

When accessing the machine from network, I can see that either application,
or X itself is running as close as possible to 100% CPU utilization.

Symptom is such that the application, or X-server, is executing an ioctl()
on a file-handle that has node:   /dev/drm/card0    open in r/w mode.

Following is from memory:

    ioctl(5, something, something)
    -- Received ALARM(0) --
    ioctl(5, something, something)
    -- Received ALARM(0) --

that repeats as fast as possible.

I have now  Radeon 9200SE card with 128 MB memory (I used to have Matrox
MGA G400 AGP with 8 MB memory - no room for anything but pixel maps), but
then I absolutely needed accelerated 3D, and had to go and get a "modern"
card.

System is running  Fedora Core 4 Test-1  application space codes along
with fresh baseline 2.6.11 + 2.6.12-rc2 patchset ( = "2.6.12-rc2" ).


I observed that xscreensaver-demo running "GLForestFire" is reliably
able to hangup the desktop within minutes, IF media-automounter is
snooping around in /dev/cdrom and there is some disk.  (I had FC4test1
rescue disk in there. )

With disk taken out, the system ran some 8 hours without a glitch.

Nevertheless, I then tried some fun with TuxRacer, and was able to
get the same drm hangup after an hour or so.


ANY ideas ?

/Matti Aarnio
