Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbTCZPwp>; Wed, 26 Mar 2003 10:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261730AbTCZPwp>; Wed, 26 Mar 2003 10:52:45 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:41234 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261728AbTCZPwo>;
	Wed, 26 Mar 2003 10:52:44 -0500
Date: Wed, 26 Mar 2003 17:03:50 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Erik Hensema <erik@hensema.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Message-ID: <20030326160350.GA11190@win.tue.nl>
References: <20030326013839.0c470ebb.akpm@digeo.com> <slrnb8373s.19a.usenet@bender.home.hensema.net> <20030326134834.GA11173@win.tue.nl> <slrnb83ehl.196.usenet@bender.home.hensema.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnb83ehl.196.usenet@bender.home.hensema.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 03:33:26PM +0100, Erik Hensema wrote:

> > You can revert this single patch and probably all will be fine.
> 
> For now I've reverted this patch and LVM is working again.

Good.

> > More interesting would be to apply
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103956089203199&w=3
> 
> I'd rather not change the ioctl interface, since that would make dual
> booting with 2.5-vanilla harder.

The ioctl has a version field:

struct dm_ioctl {
	uint32_t version[3];
	...

and the above patch changes version 1.6.0 into 2.0.0.
With sufficiently recent user space utilities all
should work: they can find out the interface version
using the DM_VERSION ioctl, and then adapt what
they send to the kernel.
(I don't know whether such up-to-date utilities exist.)

Andries

