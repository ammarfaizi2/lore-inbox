Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTDWQh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264125AbTDWQh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:37:58 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:22027 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264124AbTDWQhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:37:52 -0400
Date: Wed, 23 Apr 2003 17:49:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mika Kukkonen <mika@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cgl_discussion@osdl.org
Subject: Re: OSDL CGL-WG draft specs available for review
Message-ID: <20030423174958.A2603@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mika Kukkonen <mika@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	cgl_discussion@osdl.org
References: <1051044403.1384.44.camel@miku-t21-redhat.koti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051044403.1384.44.camel@miku-t21-redhat.koti>; from mika@osdl.org on Tue, Apr 22, 2003 at 01:46:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    4.10 Force unmount (2) 2 Experimental Availability Core
>    4.10 Description: 
> 
>    CGL shall support forced unmounting of a filesystem.
>      * The  unmount should work even if there are open files or processes
>        in the file system.
>      * Pending  requests  should  be  ended with an error return when the
>        file system is unmounted.

This is very hard to get right.  What the expermintel implementation
you're referring to?

>    Reference projects:
>    6.1.1  Real  Time  Support  Performance (1) 1 Experimental Performance
>    Core
>    6.1.1 Description: 
> 
>    CGL  shall  provide  the  capability  of  configuring the scheduler to
>    provide  soft  real  time  support  so  that  the real time scheduling
>    latency  of  a  given  task  will  not  exceed a target offered by the
>    vendor.
>      * This  requirement  requires  that  a latency target can be set and
>        depended  upon.  As an approximation, on common commodity hardware
>        supported  by  Linux,  latency  responses in the range of 10 to 15
>        milliseconds should be considered reasonable and likely.
>      * The Validation suite can likewise specify a methodology to allow a
>        vendor  to  specify  a latency value and provide verification that
>        the specified value is satisfied.

Note that without a hard RT extention you'll only get averange latencly,
but never guaranteed.

>    6.3.1 Application (Pre)loading Non-root (2) 2 None Performance Core
>    6.3.1 Description: 
> 
>    Applications  need  to  be able to exploit the application pre-loading
>    capability  even  when they are not executing as root. A configuration
>    capability  needs  to  exist  to  allow the system loader to determine
>    eligible applications for being pre-loaded.

That means it couldn't get paged out, you can't do that without a
hard limit for user processes.

>    6.8 Page flushing 3 Experimental Performance Core
>    6.8 Description: 
> 
>    CGL  shall  allow  either  applications  or  the operator controllable
>    parameters  to  control  page-flushing  operations  to  control system
>    impact.
>      * This  capability  should  be  configurable  on  a  per-process  or
>        per-application basis and also as a global setting.
>      * The  Proof  of Concept and Architecture subgroups need to consider
>        what forms an API to support this should take.
>      * Security  needs  to  be  addressed  as  mis-  or  over-use of this
>        capability can have severe impacts on the system.
> 
>    Existing functions such as fsync() and fdatasync() are starting points
>    to describe this. The difference here is that these apply to files and
>    need  to  be  executed  by  the  application  itself rather than by an
>    administrator  or  a  "manager  program"  that monitors the system and
>    adjusts  for  different requirements. For this requirement, the system
>    needs  to also be able to flush an applications memory pages onto swap
>    space.

I don't see how you want to implement this.  The fundamental VM object
for page flushing is struct address_space and it's in no say related to
processes.

>    OSDL CGL shall provide POSIX-compatible interfaces to support direct
>    porting of common carrier grade applications. OSDL CGL shall follow
>    the IEEE Std 1003.1-2001 POSIX standard for the functional areas
>    listed below.
> 
>    The IEEE Std 1003.1-2001 POSIX System Interfaces, Issue 6 delineates
>    functional areas using margin codes. This requirements document
>    identifies those margin codes which are required or optional for a
>    POSIX distribution. The POSIX functionality required by OSDL CGL is:
>     1. Core POSIX functionality
>     2. POSIX Timers functionality
>     3. POSIX Signals functionality
>     4. POSIX Threads functionality

Without really big kernel changes it's hard to get full POSIX thread
semantics. e.g. we still don't have credential sharing for tasks.  And
it doesn't lool like this makes 2.6.  I'd rather remove this one..

>    Reference projects:
>      * Implemented in NGPT: [94]http://www-124.ibm.com/pthreads/.

Well, NGPT is maintaince only mode and I doubt there's much chance to see
this ever in glibc/ngpt.  I'd rather check this with Ullrich before adding
it to the spec..

>    8.aem Low-level Asynchronous Events 2 Started Scalability Core
>    8.aem Description: 
> 
>    OSDL  CGL  WG  specifies  that Carrier-Grade Linux 2.0 shall provide a
>    very  efficient  capability for handling a large number of essentially
>    simultaneous  asynchronous events arriving on multiple channels (e.g.,
>    multiple sockets or other similar paths.)
> 
>    CGL  needs  to  have  an  efficient  mechanism that provides the Linux
>    kernel  with  advanced  carrier-grade  capabilities. The motivation of
>    this mechanism is to enforce the system scalability and soft real-time
>    responsiveness  by  reducing contentions appearing at the kernel level
>    especially under high load.
>    8.aem POC Referrals: 
> 
>    Reference projects:
>      * Ericsson       AEM       (Asynchronous      Event      Mechanism):
>        http://sourceforge.net/projects/aem/

AEM seems like a very bad idea to add to any spec.  The code is a mess and
does about three different things that don't belong together.  Better
don't even mention it :)

>    Keeping  it  separate from the base kernel (i.e. using LIS) also would
>    be  the prudent thing to do, as providing streams in the kernel got an
>    unfavorable reception in the past in the LKML.

Code doesn't get any better by keeping it outside the tree.  This only means
issues don't get fixed - LiS is the best example for this. 

