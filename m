Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTDWVz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTDWVz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:55:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31178 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264264AbTDWVzy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:55:54 -0400
Message-ID: <3EA70DC8.187CDD25@us.ibm.com>
Date: Wed, 23 Apr 2003 15:03:52 -0700
From: Peter Badovinatz <tabmowzo@us.ibm.com>
Organization: IBM Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mika Kukkonen <mika@osdl.org>
CC: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       cgl_discussion@osdl.org
Subject: Re: [cgl_discussion] Re: OSDL CGL-WG draft specs available forreview
References: <1051044403.1384.44.camel@miku-t21-redhat.koti>
		 <20030423174958.A2603@infradead.org> <1051122743.7515.97.camel@miku-t21-redhat.koti>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Kukkonen wrote:
> 
> On Wed, 2003-04-23 at 09:49, Christoph Hellwig wrote:
> > >    4.10 Force unmount (2) 2 Experimental Availability Core
> (...)
> > This is very hard to get right.  What the expermintel implementation
> > you're referring to?
> 
> This feature was mentioned in v1.1 spec, so some distributions already
> provide "experimental" versions of this feature. There are no Open
> Source projects I know of, though.

It is hard to get right, I personally cannot vouch for Solaris 8 or
Veritas (VxFS) having gotten it right.  We list it because of the
expressed desire to control file system mountings in clustered
environments.  One option is to shut down a node where the file system
is mounted, but for various reasons you would like a finer level of
control.

MontaVista claims support (see http://www.mvista.com/tech3.html) in
their Carrier Grade Edition Linux product release.  The 'Experimental'
is because this does exist, but I don't know how well it works, and
whether it's been proposed for mainstream inclusion.

> 
> > >    6.8 Page flushing 3 Experimental Performance Core
> (...)
> > I don't see how you want to implement this.  The fundamental VM object
> > for page flushing is struct address_space and it's in no say related to
> > processes.
> 
> I'll let somebody wiser than me to comment on this one, as I do not
> recall the reasoning behind this feature right know ;-)

The goal of this requirement is to allow the applications running on the
system to have deep control of the allocation of system resources.  In
response to some stimulus they can decide they want their allocated
pages released via this hypothetical flush.

A better analogue might be to madvise() and munmap(), although
generalized beyond mmap'ped pages.  In other words, the phrasing needs
to be improved here to be more accurate.  Since most of the text is
mine, and not the folks who've worked with me on it, blame me.

As to implementation, it is 'Experimental' because support exists for
some kinds of pages, ala madvise().  For the more generic case, I see
your point.  In part, we convey this making it priority 3 to allow time
to think on it, but we also don't want to limit possible solutions,
rather identify the need and help inspire the effort.


> > >    Reference projects:
> > >      * Implemented in NGPT: [94]http://www-124.ibm.com/pthreads/.
> >
> > Well, NGPT is maintaince only mode and I doubt there's much chance to see
> > this ever in glibc/ngpt.  I'd rather check this with Ullrich before adding
> > it to the spec..
> 
> Yes, we follow what is happening around. Really the requirement is just
> to get POSIX threads, if it gets done by NPTL we are OK with that. NGPT
> is mentioned because some distros currently ship with it and so from
> CGL viewpoint fulfill this requirement with NGPT.

Note that NGPT already implemented some specific interfaces [Robust
Mutexes] that are not part of Posix threads (rather, part of Solaris
(Unix International) threads in this case), and this function was
identified as being very important for compatibility for many existing
carrier applications.

I believe that Ulrich has already commented negatively on this support
in glibc/nptl, because it isn't POSIX.  But I'm uncomfortable completely
dropping this from the spec as we're trying to identify requirements as
viewed by some class of users (i.e., carrier applications.)  I can see
an adjustment of priority or other recognition (it's a 1, make it a 2,
and let the discussions play out over time.)

Peter
--
Peter R. Badovinatz aka 'Wombat' -- IBM Linux Technology Center
preferred: tabmowzo@us.ibm.com / alternate: wombat@us.ibm.com
These are my opinions and absolutely not official opinions of IBM, Corp.
