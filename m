Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264185AbTDWSUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbTDWSUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:20:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4798 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264185AbTDWSUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:20:22 -0400
Subject: Re: [cgl_discussion] Re: OSDL CGL-WG draft specs available for
	review
From: Mika Kukkonen <mika@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cgl_discussion@osdl.org
In-Reply-To: <20030423174958.A2603@infradead.org>
References: <1051044403.1384.44.camel@miku-t21-redhat.koti>
	 <20030423174958.A2603@infradead.org>
Content-Type: text/plain
Organization: OSDL
Message-Id: <1051122743.7515.97.camel@miku-t21-redhat.koti>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 11:32:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 09:49, Christoph Hellwig wrote:
> >    4.10 Force unmount (2) 2 Experimental Availability Core
(...)
> This is very hard to get right.  What the expermintel implementation
> you're referring to?

This feature was mentioned in v1.1 spec, so some distributions already
provide "experimental" versions of this feature. There are no Open
Source projects I know of, though.

> >    6.1.1  Real  Time  Support  Performance (1) 1 Experimental Performance
> >    Core
(...)
> Note that without a hard RT extention you'll only get averange latencly,
> but never guaranteed.

Yes, we are aware of this and have accepted this limitation.

> >    6.3.1 Application (Pre)loading Non-root (2) 2 None Performance Core
(...)
> That means it couldn't get paged out, you can't do that without a
> hard limit for user processes.

Well, in the system where the use of app-preloading is planned to done
the unit in question will most likely be diskless, i.e. have no swap.
It will load _all_ of it's applications over network (like NFS) at boot
time (we assume there is enough physical memory). 

Note that this feature requires support in glibc, and I talked with
Ullrich in January and he said he is not going to merge the patch that
was sent to him, because he considers it too off-beat. So this will
require extra work for distros.

> >    6.8 Page flushing 3 Experimental Performance Core
(...)
> I don't see how you want to implement this.  The fundamental VM object
> for page flushing is struct address_space and it's in no say related to
> processes.

I'll let somebody wiser than me to comment on this one, as I do not
recall the reasoning behind this feature right know ;-)

> >    OSDL CGL shall provide POSIX-compatible interfaces to support direct
> >    porting of common carrier grade applications. OSDL CGL shall follow
> >    the IEEE Std 1003.1-2001 POSIX standard for the functional areas
> >    listed below.
(...)
> Without really big kernel changes it's hard to get full POSIX thread
> semantics. e.g. we still don't have credential sharing for tasks.  And
> it doesn't lool like this makes 2.6.  I'd rather remove this one..

Ah, we are not aiming to get our features into a certain kernel version,
and actually we do not expect or even want (because of 2.6
stabilization) that our v2 spec kernel features get merged into 2.6 at
this point of time (some of them might, though).

For us it is enough that the distros will pick most of the features
after v2 specs get released and through that adaption some of
those features will get merged into 2.7 or whatever is coming after 2.6.
So we are not in hurry ;-)

One thing that tends to be debated quite often in CGL is that some
people think that POSIX specs are religious texts to be followed
literally, while some believe that the writers were human and so
we should evaluate carefully which POSIX features are actually used by
the industry. Oh well ...

> >    Reference projects:
> >      * Implemented in NGPT: [94]http://www-124.ibm.com/pthreads/.
> 
> Well, NGPT is maintaince only mode and I doubt there's much chance to see
> this ever in glibc/ngpt.  I'd rather check this with Ullrich before adding
> it to the spec..

Yes, we follow what is happening around. Really the requirement is just
to get POSIX threads, if it gets done by NPTL we are OK with that. NGPT
is mentioned because some distros currently ship with it and so from
CGL viewpoint fulfill this requirement with NGPT.

> >    8.aem Low-level Asynchronous Events 2 Started Scalability Core
(...)
> AEM seems like a very bad idea to add to any spec.  The code is a mess and
> does about three different things that don't belong together.  Better
> don't even mention it :)

Ahem, yes, there has been some ... errr... debate about AEM on
cgl_discussion also. I will just say that asynchronous events seems
to be a required feature, how it gets implemented is different story.

> >    Keeping  it  separate from the base kernel (i.e. using LIS) also would
> >    be  the prudent thing to do, as providing streams in the kernel got an
> >    unfavorable reception in the past in the LKML.
> 
> Code doesn't get any better by keeping it outside the tree.  This only means
> issues don't get fixed - LiS is the best example for this. 

Well, I'll not get into debate about code quality, but rather I'll point
out that from customers viewpoint:
  a) bad implementation is better than no implementation (well, it is
     easier to "sell" something than nothing ;-)
  b) our spec (and the whole CGL) is only doing "guidance"; what the
     individual projects, distro companies or their customers do is
     out of our hands

As noted in above snippet, we acknowledge that STREAMS (and LiS as project)
probably has no change to get merged, and because of the limited lifetime
of the feature (STREAMS really seems to be a legacy support thingy), it
makes no sense even think about merging STREAMS support to mainline. But
that is our opinion, feel free to disagree.

Thanks for your comments!

--MiKu


