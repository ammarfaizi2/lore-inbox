Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbUJ2EjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUJ2EjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 00:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUJ2EjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 00:39:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:62618 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261761AbUJ2EjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 00:39:03 -0400
Date: Thu, 28 Oct 2004 23:38:07 -0500
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kobject hotplug: don't let SEQNUM overwrite other vars (was Re: usb hotplug $DEVICE empty)
Message-ID: <20041029043807.GA12309@kroah.com>
References: <20041027115943.GA1674@xeon2.local.here> <52pt32ywwg.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52pt32ywwg.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 09:24:15PM -0700, Roland Dreier wrote:
> I think this trivial patch should fix this for you.  (Greg, not sure
> if you have this already -- it's not in Linus's tree yet in any case)

No, people are still working on getting this right.

> Prevent SEQNUM from overwriting kset-specific hotplug environment vars.

No, this puts back the problem where if the hotplug() subsystem call
fails, we have already incremented the seqnum without emitting a call
with that number.

Now I know userspace needs to handle this properly anyway, but we might
as well get the kernel right, and not do stuff to make userspace unhappy
if we can obviously help it.

I'll work on fixing this up properly tomorrow,

thanks,

greg k-h
