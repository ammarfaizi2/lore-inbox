Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271394AbRHOUGh>; Wed, 15 Aug 2001 16:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271397AbRHOUG1>; Wed, 15 Aug 2001 16:06:27 -0400
Received: from c2bapps2.btconnect.com ([193.113.209.22]:27310 "HELO
	c2bapps2.btconnect.com") by vger.kernel.org with SMTP
	id <S271394AbRHOUGP>; Wed, 15 Aug 2001 16:06:15 -0400
Date: Wed, 15 Aug 2001 21:06:22 +0100
To: Andrea Arcangeli <andrea@suse.de>
Cc: Kurt Garloff <garloff@suse.de>, linux-lvm@sistina.com,
        lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
Message-ID: <20010815210622.A1221@btconnect.com>
In-Reply-To: <20010815175659.A29749@sistina.com> <20010815182548.U3941@gum01m.etpnet.phys.tue.nl> <20010815185005.A32239@sistina.com> <20010815190428.A11146@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010815190428.A11146@athlon.random>; from andrea@suse.de on Wed, Aug 15, 2001 at 07:04:28PM +0200
From: Joe Thornber <thornber@btconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 07:04:28PM +0200, Andrea Arcangeli wrote:
> On Wed, Aug 15, 2001 at 06:50:05PM +0200, Heinz Mauelshagen wrote:
> > offset. No known way around this.
> 
> As said in the attached email (never got a reply about it yet btw)
> there's definitely a way around it, there's no magic in the beta7
> lvmtools, anything they can do can be done as well in the new lvmtools
> if we want to (and I believe we want to). I understand you don't want to
> clobber the core code with backwards compatibility cruft, but a new
> backwards compatibility utility, even in a new directory to make obvious
> nothing gets clobbered, could be developed and it would solve the
> problem.

I'm sorry I didn't reply to you Andrea, I didn't mean to be
disrespectful, but I didn't seem to be able to make my position
clear.  Let me try again:

In previous beta releases of LVM the PE position was always being
calculated, rather than calculated upon PV creation and put in the
metadata.  I was not aware of this.

This calculation varied through the beta series, it was based on some
constants that I changed (eg, SECTOR_SIZE which I changed to support
rawio), and constants that other people changed.  This means that
different betas have PE's at different places.

The correct solution to this (IMO) is to add the missing pe_start
field to the metadata.

>From looking at the metadata I have no way of knowing which version of
software the PV was created with.  This is a sorry state of affairs,
but sadly true.  So the upgrade script does the following:

o interrogate the existing tools that created the PV to find where they put
  the PE's

o write this value into the new field.

At this point the new driver, and tools should be installed.

Should beta8 code go into the kernel ? possibly not.  I think this could cause
people a lot of trouble if they are not familiar with the issues.

Should we have made the change ? yes.  If you *do* care you can choose
to upgrade.

- Joe
