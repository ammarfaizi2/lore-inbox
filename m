Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUJTP6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUJTP6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268511AbUJTP6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:58:37 -0400
Received: from mxsf10.cluster1.charter.net ([209.225.28.210]:44722 "EHLO
	mxsf10.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S268404AbUJTPzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:55:05 -0400
X-Ironport-AV: i="3.85,155,1094443200"; 
   d="scan'208"; a="359964271:sNHT13319820"
Subject: Re: [PATCH] Make kbtab play nice with wacom_drv in Xorg/XFree86
From: Dave Ahlswede <mightyquinn@charter.net>
Reply-To: mightyquinn@letterboxes.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041020130447.GA8086@ucw.cz>
References: <1098271641.26932.12.camel@sayuki>
	 <20041020130447.GA8086@ucw.cz>
Content-Type: text/plain
Date: Wed, 20 Oct 2004 11:55:02 -0400
Message-Id: <1098287702.28045.9.camel@sayuki>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 15:04 +0200, Vojtech Pavlik wrote:
> On Wed, Oct 20, 2004 at 07:27:21AM -0400, Dave Ahlswede wrote:
> 
> > In its current state, the kbtab driver can be made to work with the
> > XF86/Xorg Wacom driver, but only once per modprobe. If X is restarted,
> > the driver won't report any input events. This is because the driver
> > always reports the pen tool as being in use, and the information doesn't
> > seem to be passed after the first time the device is opened.
> > 
> > This patch fixes the issue by causing the driver to briefly report the
> > pen not in use each time the device is opened. 
> 
> It's a bug in the X Wacom driver that it doesn't check the initial state
> of the tool. It should use EVIOCGKEY() to do that.

I'll talk to the developer about that, thanks.

> A good way to get this working in the driver would be report the PEN
> tool as not in use when the position is invalid (the pen is not within
> reach), if that is possible with the hardware. It's what the bit should
> signify.

Unfortunately, when the pen is out of bounds, the hardware simply stops
sending packets. I experimented with a change that would report no tool
in use when pressure was zero, but that made the tablet unusable. (It
would only track movement when the pen was being pressed to the tablet)



