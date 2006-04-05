Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWDER11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWDER11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWDER11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:27:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64450 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751299AbWDER10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:27:26 -0400
Date: Wed, 5 Apr 2006 18:27:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Message-ID: <20060405172725.GN27946@ftp.linux.org.uk>
References: <20060404235634.696852000@quad.kroah.org> <20060404235947.GD27049@kroah.com> <20060405190928.17b9ba6a.vsu@altlinux.ru> <20060405152123.GH27946@ftp.linux.org.uk> <9e4733910604050934s46ec20fbr905f78832431d91d@mail.gmail.com> <20060405170226.GL27946@ftp.linux.org.uk> <9e4733910604051006q447ec3absec038732c5a7a9f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910604051006q447ec3absec038732c5a7a9f2@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 01:06:32PM -0400, Jon Smirl wrote:
> On 4/5/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> > On Wed, Apr 05, 2006 at 12:34:49PM -0400, Jon Smirl wrote:
> > > On 4/5/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> > > > On Wed, Apr 05, 2006 at 07:09:28PM +0400, Sergey Vlasov wrote:
> > > > > This will break the "color_map" sysfs file for framebuffers -
> > > > > drivers/video/fbsysfs.c:store_cmap() expects to get exactly 4096 bytes
> > > > > for a colormap with 256 entries.  In fact, the original patch which
> > > > > changed PAGE_SIZE - 1 to PAGE_SIZE:
> > > >
> > > > ... cheerfully assuming that nobody assumes NUL-termination and
> > > > everyone (sysfs patch writers!) certainly uses the length argument.
> > > > Fscking brilliant, that.
> > >
> > > Why does sysfs have two string length determination methods - both
> > > NULL termination and a length parameter. It should be one or the
> > > other, not both. Having both simply cause problems when some
> > > developers implement one scheme and others only implement the other.
> >
> > Which part of "sysfs patches can be written by idiots and usually are"
> > is too hard to understand?  Oh, wait.  I see...  Well, nevermind, then...
> 
> I look forward to seeing your patches address these problems.

I don't patch wetware.  As for the NUL-termination, fixing widespread breakage
you've introduced is _your_ responsibility.  Preferably taken care of before
submitting the patch in question.  As far as I'm concerned, reverting it
solves the problem.

I'm sorry, but by now I'm _REALLY_ sick and tired of sysfs wankers crowd
and your brand of idiocy is getting slightly past the annoying stage.
Let me spell it out for you:
	1) when you change the property of implementation, you must at least
try to check how much might rely on it.
	2) when interface is not documented, do not assume that its properties
are accidental and/or not relied upon.
	3) if you are breaking things, at least make sure that breakage is
easily found.  Do not introduce an obscure case when old assumption is false;
make it visible.
	4) when considerable part of interface users is obviously broken
by a change and you want to preserve that change, suggesting that somebody
else should fix the interface users for you since they did not match your
assumptions is... not the brightest idea in the world.
