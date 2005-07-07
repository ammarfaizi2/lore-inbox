Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVGGTtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVGGTtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVGGTNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:13:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:45014 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262228AbVGGTMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:12:15 -0400
Date: Thu, 7 Jul 2005 12:04:55 -0700
From: Greg KH <greg@kroah.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050707190455.GA19570@kroah.com>
References: <1120668881.8328.1.camel@localhost> <200507062133.05827.sgrubb@redhat.com> <20050707181530.GB21072@kroah.com> <200507071449.10271.sgrubb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507071449.10271.sgrubb@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 02:49:09PM -0400, Steve Grubb wrote:
> On Thursday 07 July 2005 14:15, Greg KH wrote:
> > I fail to see any refactoring here, why not make your patch rely on
> > theirs?
> 
> At the time this code was developed, inotify was not in the kernel. We would 
> be patching against another patch that's not in the kernel.

You all are asking for this patch to be added to -mm, which contains
inotify.

> > > The whole rest of it is different. I hope the inotify people comment
> > > on this to see if there is indeed something that should be refactored.
> >
> > I realize your userspace access is different, yet I do not believe yet
> > that it should be this way.
> 
> The problems that we are faced with are dictated by CAPP and other security 
> profiles. The audit user space access has been in the kernel for over a year, 
> so that's not really a good thing to go changing.

You are adding auditfs, a new userspace access, right?  That's what I am
referring to.

> > No documentation on the auditfs interface :(
> 
> That's what Tim's email was providing. Its a new component.

His email provided no documentation that I could see.  Am I just missing
something?

> > > The audit package is currently distributed in Fedora Core 4. The code to
> > > use Tim's fs audit code is in the user space app, but is waiting for the
> > > kernel pieces.
> >
> > So the userspace package in FC4 will not use auditfs?
> 
> Right. You get a few warnings due to missing functionality. If the kernel were 
> patched with Tim's code, it all works as expected. We have worked out the 
> user space access and that shouldn't be changing.

Then what use is auditfs for if you don't need it?

Am I correct in thinking that you all need to split this patch into two
pieces, the new inode stuff, and auditfs, as neither one has anything to
do with the other?

Confused,

greg k-h
