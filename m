Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVCIQ6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVCIQ6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVCIQ6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:58:51 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:64645 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261856AbVCIQ5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:57:49 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: xorg@lists.freedesktop.org, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
Date: Wed, 9 Mar 2005 08:57:14 -0800
User-Agent: KMail/1.7.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Egbert Eich <eich@freedesktop.org>, Jon Smirl <jonsmirl@yahoo.com>,
       xorg@freedesktop.org, Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1110265919.13607.261.camel@gaston> <1110346634.32556.54.camel@gaston> <9e4733910503082158c95c904@mail.gmail.com>
In-Reply-To: <9e4733910503082158c95c904@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503090857.15448.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 8, 2005 9:58 pm, Jon Smirl wrote:
> On Wed, 09 Mar 2005 16:37:13 +1100, Benjamin Herrenschmidt
>
> <benh@kernel.crashing.org> wrote:
> > On Tue, 2005-03-08 at 23:35 -0500, Jon Smirl wrote:
> > > This is from /linux-2.5/Documentation/filesystems/sysfs-pci.txt. It
> > > describes how ia64 is achieving legacy IO.  The VGA control code
> > > probably needs to be coordinated with this.
> >
> > This is a different thing, and I will implement it on ppc one of these
> > days. This is for issuing the IO cycles on the bus. It has nothing
> > to do with the actual arbitration work.
>
> Each one of these legacy spaces corresponds to an allowable
> simultaneous VGA use. There should be one arbiter per legacy space.

Jon, I think the arbiters have to be per-resource rather than per-legacy 
space.  AIUI, the arbiters are there to deal with multiple devices on the 
same bus that respond to the same cycles, like two VGA cards in one legacy 
I/O domain.  You either need to relocate one of them so that they don't have 
overlapping I/O ranges or disable one while you talk to the other.

IOW, legacy space is the whole I/O window of a given bus or PCI domain 
(granularity defined by the platform--some will only have one I/O space), and 
the arbiter's job is to arbitrate access to subsets of each window.  I think 
the the VGA stuff here complements the legacy interface rather than 
conflicting with it.

Jesse
