Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262096AbTCZUlX>; Wed, 26 Mar 2003 15:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbTCZUlX>; Wed, 26 Mar 2003 15:41:23 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:58631 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S262096AbTCZUlV>;
	Wed, 26 Mar 2003 15:41:21 -0500
Date: Wed, 26 Mar 2003 21:52:28 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Erik Hensema <erik@hensema.net>, linux-kernel@vger.kernel.org
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
Message-ID: <20030326205228.GA11217@win.tue.nl>
References: <20030326013839.0c470ebb.akpm@digeo.com> <slrnb8373s.19a.usenet@bender.home.hensema.net> <20030326134834.GA11173@win.tue.nl> <slrnb83ehl.196.usenet@bender.home.hensema.net> <20030326160350.GA11190@win.tue.nl> <20030326184723.GM19670@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326184723.GM19670@ca-server1.us.oracle.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 10:47:23AM -0800, Joel Becker wrote:

> We need to start tracking down what userspace needs fixing.

My current series of patches is for the ioctls that use a
structure with dev_t field. If someone has time to burn,
or has automated tools that can identify these, that would
be good.

There is a double audit: find these ioctls, and then find
the userspace tools that use them.

For example, struct umsdos_ioctl has twice dev_t followed
by padding. Probably these should become unsigned longs.
I'll send a patch later tonight.

Is it used anywhere? That requires detective work.
It is used by the utilities udosctl (a useless demo utility),
umssync and umssetup. I do not know of any others.
No doubt people will tell me what I overlooked.
Less conservative people will tell me that umsdos has to
be killed entirely.

In old posts and other letters I have mentioned some more ioctls.
The list is not long but they have to be examined one by one,
and in some cases correspondence with authors/maintainers
is required.

> We also should iron out our representations.  eg, hpa's
> recommendation for 64bits, or the 12/20 split for 32bit, or etc.

There is no hurry. These changes are just editing a few lines
in kdev_t.h. I tend to prefer 64 bits, like hpa.
Maybe I should send another patch tonight, just for playing.

Andries

