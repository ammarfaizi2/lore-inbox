Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUE1RHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUE1RHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUE1RHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:07:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:17315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261706AbUE1RHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:07:37 -0400
Date: Fri, 28 May 2004 10:03:15 -0700
From: Greg KH <greg@kroah.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Leave runtime suspended devices off at system resume
Message-ID: <20040528170315.GB8192@kroah.com>
References: <20040526214319.GB7176@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526214319.GB7176@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 02:43:19PM -0700, Todd Poynor wrote:
> Currently all devices are resumed at system resume time, including any
> that were individually powered off ("at runtime") prior to the system
> suspend.  In certain cases it can be nice to force back on individually
> suspended devices, such as the display, but hopefully this policy can be
> left up to userspace power managers; the kernel should probably honor
> the settings previously made by userspace/drivers.  This seems
> preferable to requiring a power-conscious system to re-suspend devices
> after a system resume; furthermore, for certain platforms (such as
> XScale PXA27X) there can be disastrous consequences of powering up
> devices when the system is in a state incompatible with operation of the
> device.
> 
> Suggested patch does this:
> 
> (1) At system resume, checks power_state to see if the device was
> suspended prior to system suspend, and skips powering on the device if
> so.
> 
> (2) Does not re-suspend an already-suspended device at system suspend
> (using a different method than is currently employed, which reorders the
> list, see #3).
> 
> (3) Preserves the active/off device list order despite the above changes
> to suspend/resume behavior, to avoid dependency problems that tend to
> occur when the list is reordered.

Nice, that looks good.

Applied, thanks.

greg k-h
