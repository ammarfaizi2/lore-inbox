Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWHNXzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWHNXzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWHNXzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:55:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:30112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932739AbWHNXzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:55:42 -0400
Date: Mon, 14 Aug 2006 16:52:08 -0700
From: Greg KH <greg@kroah.com>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Linux DVB <linux-dvb@linuxtv.org>
Subject: Re: 2.6.18-rc3-mm2:  oops in device_bind_driver()
Message-ID: <20060814235208.GA12912@kroah.com>
References: <1155385726.6151.6.camel@Homer.simpson.net> <20060812180256.445caea9.akpm@osdl.org> <1155448234.7068.1.camel@Homer.simpson.net> <20060814210308.GH11673@kroah.com> <1155590934.13789.19.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155590934.13789.19.camel@praia>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 06:28:54PM -0300, Mauro Carvalho Chehab wrote:
> Em Seg, 2006-08-14 ?s 14:03 -0700, Greg KH escreveu:
> > On Sun, Aug 13, 2006 at 05:50:34AM +0000, Mike Galbraith wrote:
> > > On Sat, 2006-08-12 at 18:02 -0700, Andrew Morton wrote:
> > > 
> > > > I'd assume that you have CONFIG_PCI_MULTITHREAD_PROBE set, and
> > > 
> > > Yes.
> > 
> > Mauro, this is odd.  Anything in the dvb layer that would not like
> > multiple devices being probed at the same time?
> We should hardly check for all race conditions. It is likely to cause
> some random troubles at both V4L and DVB sides. 
> 
> For example, on V4L side, this may produce weird stuff like bad device
> number associations (for example, the same device might get /dev/video0
> and /dev/radio1, but apps expects to have the same numbering for
> both)...
> 
> The same on DVB: demux0 should be associated with frontend0, for DVB to
> work properly, but, with simultaneous probing, this might not happen.

How do you prevent this from happening today, with USB devices showing
up at any point in time, combined with PCI hotplug devices?

> For sure some newer locks will be required for multithread probe.

I think you need it even without this PCI change :)

thanks,

greg k-h
