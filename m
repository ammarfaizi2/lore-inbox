Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUH3PFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUH3PFd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUH3PFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:05:33 -0400
Received: from ihemail1.lucent.com ([192.11.222.161]:63175 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP id S268088AbUH3PEy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:04:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16691.16656.726300.438533@gargle.gargle.HOWL>
Date: Mon, 30 Aug 2004 11:00:32 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       Rik van Riel <riel@redhat.com>, Spam <spam@tnonline.net>,
       Jamie Lokier <jamie@shareable.org>, David Masover <ninja@slaphack.com>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <4131074D.7050209@namesys.com>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
	<Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org>
	<20040828170515.GB24868@hh.idb.hist.no>
	<Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org>
	<4131074D.7050209@namesys.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hans> My reason is that the things that distinguish between objects
Hans> should be the names, not the choice of system call.  The reason
Hans> for this is that it improves closure and namespace unification
Hans> to do so, because it allows all the objects to be accessed
Hans> within the same namespace.

So who decides what the names mean in a specific context?  How do we
get consistency across applications?  In the Apple and MicroSoft
cases, it's a single company which sets the standards for the names of
the streams and what they mean.  I have no knowledge of how Sun is
doing this.  I don't see us setting up a single naming authority and
enforcement mechanism.  

I went and read the Pike paper on namespaces which Hans quotes much
earlier in this thread, and I think it isn't applicable to this
thread.  In the paper Pike compares the MVS, VMS, DOS and Unix name
spaces for disk layouts.  It's an interesting paper, though a bit
dated since it's 20 years old.  The concepts are good, but the
examples aren't any more.  How many Unix systems today have
/n/faces/... to link email addresses to digitized images of people
faces? 

The big point of this paper though was to make the syntax simple, and
the semantics clear and unambiguous.  For example, they point out how
the "Cedar" file system added in VMS style version numbers to
filenames with the syntax "<name>!<version>" and they pointedly ask
what does "/usr/rob!3/bin/cat-v mean?  Which I think just points out
that the syntax of streams (metas) needs be carefully thought out, and
how that syntax implies various semantics.  

Lots of people keep asking for ACLs, but time and time again people
point out that while the Unix permission model isn't as flexible, it
is _simpler_ and easier to keep track of.  

As an example of complexity, just keeping track of our /etc/sudoers
file with all the users, hosts and commands that can be defined is a
huge hassle.  You pretty much need to have a 'lint' style program to
do the consistency checking.  

Hans> Yes, it can be useful to allow a namespace to exclude some
Hans> objects, but that exclusion should not be mandated.  

Conversely, should a namespace *require* that objects always be there?
What happens when I mount an NFS filesystem onto a Resierfs4 tree?
How does the user/apps determine when the semantics of the underlying
namespace have changed?  

Hans> If you want to exclude, you should cd or chroot to
Hans> /proc/nopseudos and find a view of the filesystem that excludes
Hans> metas, or mount with -nopseuodos.

Hans> Do you see why I say this?  I can say a lot more about the
Hans> damage of fragmenting namespaces into multiple apis.... Why look
Hans> at xattrs....;-)

I think one of the advantages of the xattrs is that the core namespace
doesn't change, nor do the semantics.  They are layered on top and can
be explicitly looked at.  

A real life problem of namespaces is Network Appliance Filers.  If you
have a filer with both NFS and CIFS exports, it will nicely manage the
CIFS ACLs in harmony (for some level you determine) with the NFS and
Unix permissions.  But to backup that data, and to store that
information, you need to use either their 'dump' tool or NDMP.  If you
NFS mount the filesystem to your backup host and then use a simple tar
to back it up, you lose the information since that window you use to
look into the namespace is restricted.  

It's a gotcha.  Until we can (or maybe computing in general) come up
with a new namespace paradym which we can all agree to, this is going
to be a big issue.  

John
