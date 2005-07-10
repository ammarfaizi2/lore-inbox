Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVGJTAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVGJTAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVGJTAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:00:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:55690 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261156AbVGJTAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:00:17 -0400
Date: Sun, 10 Jul 2005 11:59:54 -0700
From: Greg KH <greg@kroah.com>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050710185954.GB18639@kroah.com>
References: <1120668881.8328.1.camel@localhost> <200507071449.16280.tinytim@us.ibm.com> <20050708174645.GE30908@kroah.com> <200507081448.04394.tinytim@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507081448.04394.tinytim@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 02:48:03PM -0500, Timothy R. Chavez wrote:
> I've chosen not to respond to individual segments because the overall theme
> is that the right thing to do is to not duplicate functionality.

Correct.

> Your suggestion is to merge the two projects.

Or at the minimal, the common parts of them.

> In your mind, this benefits both projects.

I'm guessing that you don't think this will?

> It will 
> consolidate the common functionality and enhance Inotify such that it is not 
> only an event notification system for user space, but for other parts of the 
> kernel -- namely audit -- as well.  Is this a fair assessment?

Correct.

> I think we can all agree that functionality should not be duplicated.  I have 
> conceded that having two seperate hooks side-by-side that have the same 
> purpose should be consolidated.  Because this would be generic, all other
> notification hooks should be available to Inotify (and any other subsystem) 
> as well.  Agreed?

Yes.

> My vision is that audit, Inotify, and whatever else plugs into this framework 
> and receives notifications this way -- a file system event notification system 
> for the kernel.  Then, audit, Inotify, etc would process this even information 
> it receives and does with it what they will.

Sounds good.

> Ultimately, the part where we differ most, is the processing of information in 
> fs/dcache.c to give dynamic updates in response to file system activity (such 
> as attaching audit information to an auditable file whose inode just changed).  
> I believe this should be kept seperate and not part of this framework nor Inotify.  
> It's a specific requirement for audit, but not for Inotify.  This is one of the places 
> the two systems are functionally different.

I don't think it should be different.  If inotify wants to just ignore
this information, it can.

> By doing it this way, both projects can retain their original goals and meet 
> their individual requirements, and all the common pieces are consolidated in 
> a logical way.  This is something Robert and I had discussed on LKML in early  
> December 2004, and was brought up in a discussion more recently for an RFC 
> on LKML in early June between Christoph Hellwig and myself.

I'm very sad to see you ignored these comments by others.  Any reason
why?  It is pretty rude...

> Can this patch not be placed in -mm for the time being, as-is?  Surely the 
> logic it implements, what I envision will ultimately be retained, could benefit 
> from the exposure in the interim?

Why not get it right, you agree that you know how to do this, and that
it should be done.  What's the point of adding it now, as it will be
redone anyway?  That would cause more work for others (andrew doesn't
maintain patches for free in -mm), and cause reports from people for a
codebase that is not going to ever make it into mainline.

Just do the right thing, you know what it is.

thanks,

greg k-h
