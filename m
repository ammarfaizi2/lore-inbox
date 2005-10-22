Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbVJVNYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbVJVNYE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 09:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbVJVNYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 09:24:04 -0400
Received: from wind.enjellic.com ([209.243.13.15]:51720 "EHLO
	wind.enjellic.com") by vger.kernel.org with ESMTP id S1751337AbVJVNYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 09:24:02 -0400
Message-Id: <200510221323.j9MDNimA009898@wind.enjellic.com>
From: greg@wind.enjellic.com (Dr. Greg Wettstein)
Date: Sat, 22 Oct 2005 08:23:43 -0500
In-Reply-To: Mike Waychison <mikew@google.com>
       "Re: /etc/mtab and per-process namespaces" (Oct 13,  7:10pm)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: Mike Waychison <mikew@google.com>, Ram <linuxram@us.ibm.com>
Subject: Re: /etc/mtab and per-process namespaces
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, leimy2k@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 13,  7:10pm, Mike Waychison wrote:
} Subject: Re: /etc/mtab and per-process namespaces

Good morning to everyone, really behind on e-mail, my apologies for
joining the thread late.

> Ram wrote:
> > On Tue, Oct 04, 2005 at 12:14:47PM -0700, David Leimbach wrote:
> > 
> >>Hmm no responses on this thread a couple days now.  I guess:
> >>
> >>1) No one cares about private namespaces or the fact that they make
> >>/etc/mtab totally inconsistent.
> >>2) Private Namespaces aren't important to anyone and will never be
> >>robust unless someone who cares, like me, takes it over somehow.
> >>3) Everyone is busy with their own shit and doesn't want to deal with
> >>me or mine right now.
> >>
> >>I'm seriously hoping it's 3 :).  2 Is acceptable too of course.  I
> >>think this is important and I want to know more about the innards
> >>anyway.  1 would make me sad as I think Linux can really show other
> >>Unix's what-for here when it comes to showing off how good the VFS can
> >>be.

> Or,  you bite the bullet and fix /proc/mounts and let distributions bind 
> mount /proc/mounts over /etc/mtab.
> 
> Sun recognized this as a problem a long time ago and /etc/mnttab has 
> been magic for quite some time now.
> 
> Add to this the fact that a textfile /etc/mtab is busted because it's 
> whitespace seperated and pieces blows up and you do things like:
> 
> mount filer:/export/mikew "/home/Mike Waychison"

As to the three options above, I believe number 3 would be operative.
Private namespaces are extremely useful concepts, we are growing
increasingly dependent on them for systems management and
administration.  I believe the issue is a chicken/egg problem, without
an update in tools the concept of namespaces are less approachable
than they should be.

Mike's comments are very apt.  The current situation with mount
support is untenable.  Even working on private development machines it
gets confusing as to what is or is not mounted in various
shells/processes.  The basic infra-structure is there with process
specific mount information (/proc/self/mounts) but mount and friends
are a bit problematic with respect to supporting this.

I'm working on a namespace toolkit to address these issues.  I've got
a pretty basic tool, similar to sudo, which allows spawning processes
with a protected namespace.  I'm adding a configuration system which
allow systems administrators to define a setup of bind mounts which
are automatically executed before the user is given their shell.  I'm
also working up a PAM account module to go along with this.  I would
certainly be open to suggestions as to what else people would consider
useful in such a toolkit.

I've been pondering the best way to take on the mount problem.
Current mount binaries seem to fall back to /proc/mounts if /etc/mtab
is not present.  All bets are off of course if the mount binary is
used for the bind mount since a new /etc/mtab is created.

I'm willing to whack on the mount binary a bit as part of this.  The
obvious solution is to teach mount to act differently if it is running
in a private namespace.  If anybody knows of a good way to detect this
I would be interested in knowing that.  In newns (the namespace sudo
tool) I'm setting an environment variable for mount to detect on but a
system level approach would be more generic.

The other problem is the information exported in /proc/mounts.  It
would seem problematic to modify its format but in order to serve as a
useful source of information for a modified mount binary it would need
to contain mount option information.  Since this is definitely process
specific information it would seem to call for something in /proc
rather than /sysfs.  Do we need a new pseudo-file?

I would be certainly interested in peoples reflections on this.  When
I get something a bit more shaken down I will roll up a preliminary
distribution and announce it.

> Mike Waychison

Best wishes for a pleasant weekend to everyone.

Greg

}-- End of excerpt from Mike Waychison

As always,
Dr. Greg 'GW' Wettstein
------------------------------------------------------------------------------
                         The Hurderos Project
         Open Identity, Service and Authorization Management
                       http://www.hurderos.org
