Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUBET0w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266808AbUBET0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:26:52 -0500
Received: from gw0.infiniconsys.com ([65.219.193.226]:24837 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S266807AbUBET0U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:26:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Thu, 5 Feb 2004 14:26:19 -0500
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96BF@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsGjVG9LMkXfbHTmW9mkOBO5uEEQAAQZCw
From: "Tillier, Fabian" <ftillier@infiniconsys.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <greg@kroah.com>, <sean.hefty@intel.com>, <linux-kernel@vger.kernel.org>,
       <hozer@hozed.org>, <woody@co.intel.com>, <bill.magro@intel.com>,
       <woody@jf.intel.com>, <infiniband-general@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy,

All issues are in include/asm-x86/atomic.h

Comments as to the useful range of an atomic_t for x86 states 24-bits
atomic_add is a void.  It should return the incremented value.
atomic_sub is a void.  It should return the decremented value.
atomic_inc is a void.  It should return the incremented value.
atomic_dec is a void.  It should return the decremented value.

There is no atomic exchange.  include/asm-x86/system.h does provide a
compare exchange, but it takes an extra size parameter.

Do note that for non x86 architectures, the component library atomic
abstraction is all #define to the Linux provided functions.  Only x86
needed help because of i386 backwards compatibility which is not a goal
of the InfiniBand project.

Hope that helps.

- Fab

-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap@osdl.org] 
Sent: Thursday, February 05, 2004 10:53 AM
To: Tillier, Fabian
Cc: greg@kroah.com; sean.hefty@intel.com; linux-kernel@vger.kernel.org;
hozer@hozed.org; woody@co.intel.com; bill.magro@intel.com;
woody@jf.intel.com; infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
theLinux kernel

On Thu, 5 Feb 2004 13:31:45 -0500 "Tillier, Fabian"
<ftillier@infiniconsys.com> wrote:

| Greg,
| 
| The atomic operation abstraction is there because atomic support has
| different prototypes between x86 and IA64 (at least it did when it was
| written), with some of the x86 functions not returning values while
the
| IA64 ones did.  Further, comments in the x86 code base indicated that
| only 24-bits are actually valid (probably from some i386 limitation
that
| is no longer relevant).  Thus, the implementation of atomic operations
| for the x86 processor architecture fails a build (via #error) if
you're
| targeting an i386 processor, and provides the same semantics
independent
| of processor architecture.
| 
| To answer your broader question, the reason to have abstraction is to
| facilitate portability.  I'm not just talking about portability
between
| different operating systems, but even portability between different
| versions of Linux distributions and kernels.  Differences between
Linux
| distributions and kernel versions can be handled in a single place,
| avoiding the need to pepper the rest of the code base with #ifdefs.
| This results in more readable and maintainable code for the rest of
the
| project by concentrating platform specific issues to the abstraction
| layer.

Besides Greg's comments:

Can (will) you provide specific examples of these differences/problems?
They need to be quashed.

Thanks.

| Are you suggesting that if there is any abstraction, the code will
never
| be accepted?  Or rather that the abstraction better be correct?  I'm
| hoping for the latter, however please clarify.
| 
| - Fab
| 
| -----Original Message-----
| From: Greg KH [mailto:greg@kroah.com] 
| Sent: Thursday, February 05, 2004 10:10 AM
| To: Hefty, Sean; linux-kernel@vger.kernel.org
| Cc: Troy Benjegerdes; Woodruff, Robert J; Magro, Bill; Woodruff,
Robert
| J; infiniband-general@lists.sourceforge.net
| Subject: Re: [Infiniband-general] Getting an Infiniband access layer
in
| the linux kernel
| 
| On Thu, Feb 05, 2004 at 10:01:13AM -0800, Hefty, Sean wrote:
| > As an FYI, the code is available for download on bitkeeper at
| > http://infiniband.bkbits.net/iba.  We're still working on providing
a
| > tarball and patch for 2.6, but if you would like to see the code
now,
| it
| > is available.
| 
| Oh, I've seen that code, and still feel ill after looking at some of
| it...
| 
| Come on, implementing your own spinlocks (and getting it wrong) and
| atomit_t?  Why in the world would you _ever_ want to do that.
| 
| That code needs a _lot_ of cleanup to make it into the kernel tree.
| 
| Good luck,
| 
| greg k-h


--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
