Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291282AbSBGUgE>; Thu, 7 Feb 2002 15:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291290AbSBGUfy>; Thu, 7 Feb 2002 15:35:54 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:45833 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S291288AbSBGUe5>; Thu, 7 Feb 2002 15:34:57 -0500
Date: Thu, 7 Feb 2002 12:34:51 -0800
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020207203451.GE26826@bluemug.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16YoRQ-0000aS-00@starship.berlin> <20020207182653.GA26664@bluemug.com> <E16Yu52-00015I-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16Yu52-00015I-00@starship.berlin>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 08:19:36PM +0100, Daniel Phillips wrote:
> On February 7, 2002 07:26 pm, Mike Touloumtzis wrote:
> > 
> > I installed a custom rsync just the other day, and I did it by downloading
> > the Debian rsync source, patching it, and building a Debian package.
> > I would certainly do the same for cat if I needed to.
> > 
> > Sorry, I still don't see any fundamental difference.
> 
> Yes, and would you configure cat?  Which options would you select?
> 
> I'm trying to avoid just saying 'you're being silly', but it's what I
> really mean.

I'm talking about rsync now, not cat (that was reductio ad absurdum to
make a point).  In case you haven't compiled any userspace programs in
a while: many of them have configuration options.  In the case of rsync,
things like "--enable-profile" and "--disable-ipv6".

I fail to see how tracking a custom compiled rsync is any different
from tracking a custom compiled kernel.  In both cases you have local
history to track and a group of files to bundle together.

Let's replay this discussion as I see it:

You: Users are clamoring for the inclusion of configuration information
     in the kernel.  They clearly need it, so let's include it even
     though it has no functional purpose.

Me: Actually, I'm a user and the distribution-provided packaging tools
    work fine for this purpose.  We don't bundle similar information
    into the binaries of userspace tools.

You: Userspace tools don't have configuration options like the kernel.

Me: Yes they do.

Arguing that people don't custom configure anything but the kernel is
a dead end.  Also, I have already claimed that I don't need any of the
"stuffing config info into kernels" solutions mentioned on this thread,
so it's hard to try to convince me I need this feature.

Some possible available avenues of argument for you are:

-- "You don't know what you're missing".

   You can argue that moving configuration info into the kernel is
   fundamentally better than, or makes things easier than, bundling
   it into a package.  This is a hard sell, since in an earlier mail
   I demonstrated that I can get at the configuration info in a kernel
   package with two commands.

-- "You are not a typical user".

   Since I'm satisfied with the status quo, your best defense of this
   change is to argue that I am not the target audience for this change.

   As far as I can tell, the userbase of Linux, includes, in descending
   order of frequency:

   1) People who use prepackaged distribution kernels.
   2) People who build their own kernels based on distribution packaging
      systems, or have evolved their own systems of kernel management
      over the years.
   3) People who sling kernels around like loose change and forget where
      each kernel came from.

   AFAICT most of the "config info needs to go in the kernel" arguments
   seem to come from camp #3.  I think those people should just get
   their acts together or start using the right tools instead.

   When I first started using Unix (on a multiuser system, back in
   school), I was struck by how messy it was.  The root directories
   contained all kinds of locally added directories and forgotten crap.
   The systems were a mishmash of forgotten compiled-from-source packages,
   temporary workarounds, expedient measures, and haphazardly patcheded
   kernels.

   The extent to which the distributors and other measures like the FHS
   have rationalized this situation, and automated the tasks it sprung
   from, continues to amaze me.  My sneaking suspicion is that people
   who want to stuff configuration info into the kernel haven't made that
   leap yet.  That's why I'm being a bit of a harsh critic of the concept
   (plus, it seems to be par for the course on lkml :-).

A final argument for using packaging/bundling tools and userspace files
instead of files in /proc for tracking kernel metadata:

-- Kernels are no longer single files, at least for most people.
   A _harder_ problem than this one is tracking which modules go with
   which kernel.  Solving this problem solves the configuration tracking
   problem as a _side_effect_.  Conversely, solving the configuration
   tracking problem without solving the module tracking problem is
   largely useless.

miket
