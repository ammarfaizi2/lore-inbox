Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269270AbUISQq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269270AbUISQq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 12:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269273AbUISQq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 12:46:28 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:14669 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269270AbUISQqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 12:46:22 -0400
Message-ID: <9e47339104091909465c9a483f@mail.gmail.com>
Date: Sun, 19 Sep 2004 12:46:13 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Keith Packard <keithp@keithp.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1095569137.6580.23.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <1095569137.6580.23.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 14:45:37 +1000, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> One issue here... When we discussed all of this with Keith, we wanted
> a mecanism where the user can set the mode without "owning" the device.

The owning part is for multiuser systems. If I have four users logged
into the same system I have to assign them ownership of their video
devices so that they can't mess with each other.  I want to avoid
needing root priv to change the monitor mode.

> Typically, with X: We don't want X itself to have to be the one setting
> the mode, but rather set the mode and have X be notified properly before
> and after it happens so it can "catch up".

This is going to require some more thought. Mode setting needs two
things, a description of the mode timings and a location of the scan
out buffer.  With multiple heads you can't just assume that the buffer
starts at zero.  There also the problem of the buffer increasing in
size and needing to be moved since it won't fit where it is.

Keith, how should this work for X? We have to make sure all DRI users
of the buffer are halted, get a new location for the buffer, set the
mode, free the old buffer, notify all of the DRI clients that their
target has been wiped and has a new size.

I was wanting to switch mode setting into an atomic operation where
you passed in both the mode timings and buffer location.

-- 
Jon Smirl
jonsmirl@gmail.com
