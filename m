Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbWCAAVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWCAAVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbWCAAVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:21:55 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:55780
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932730AbWCAAVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:21:51 -0500
Date: Tue, 28 Feb 2006 16:21:52 -0800
From: Greg KH <greg@kroah.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       gregkh@suse.de, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060301002152.GD23716@kroah.com>
References: <20060227190150.GA9121@kroah.com> <9a8748490602271201j39d87e9di8d6e2c83b0439c89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490602271201j39d87e9di8d6e2c83b0439c89@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 09:01:54PM +0100, Jesper Juhl wrote:
> On 2/27/06, Greg KH <greg@kroah.com> wrote:
> > So, any comments?  Criticisms?
> >
> 
> Great initiative. Thanks.

Glad you like it.

> > +  stable/
> > +       This directory documents the interfaces that have determined to
> > +       be stable.  Userspace programs are free to use these interfaces
> 
> "have determined to be stable." ??
> How about "have proven to be stable" or "we have determined to be
> stable" or "we have defined as being stable and will not break"
> instead?

Ok, I'll change this, it is ackward wording.

> > +  testing/
> > +       This directory documents interfaces that are felt to be stable,
> > +       as the main development of this interface has been completed.
> > +       The interface can be changed to add new features, but the
> > +       current interface will not break by doing this.
> > +       Userspace programs can start to rely on these interfaces, but
> > +       they must be aware of changes that can occur before these
> > +       interfaces move to be marked stable.  Programs that use these
> > +       interfaces are strongly encouraged to add their name to the
> > +       description of these interfaces, so that the kernel developers
> > +       can easily notify them if any changes occur (see the description
> > +       of the layout of the files below for details on how to do this.)
> > +
> 
> Maybe a note here that "testing" interfaces may be change in
> incompatible ways before moving to stable/ if grave errors or security
> vulnerabilities are found in them?

Good point, added.

> > +  unstable/
> > +       This directory documents interfaces that are known to be
> > +       unstable, and not ready for widespread use by a lot of different
> > +       programs.  That is not to say that they can not be used, but
> > +       developers of such programs should track their changes very
> > +       closely.  Again, programs that uses these interfaces are
> > +       strongly encouraged to add their names to the description of the
> > +       interfaces so that they can be notified of changes.
> > +
> > +  obsolete/
> > +       This directory documents interfaces that are still remaining in
> > +       the kernel, but are marked to be removed at some later point in
> > +       time.  The description of the interface will document the reason
> > +       why it is obsolete and when it can be expected to be removed.
> > +
> 
> A note here that people should check
> Documentation/feature-removal-schedule.txt perhaps?

Yeah, I wonder if some of the things in that file can be moved to be
individual files in this directory too.

> > +  private/
> > +       This interface is private between the kernel and a helper
> > +       userspace program or library.  If you wish to use this interface
> > +       (like alsa or netlink) userspace must use the helper library and
> > +       not use the raw kernel interface directly.
> > +
> 
> Perhaps add something along the lines of "Stability of the interface
> is only guaranteed through the helper library, if you choose to
> disregard this and use the raw kernel interface anyway, then your
> program may break without warning in future kernel releases.".

I'd like to just discourage their use without the helper at all, as that
is what the developers of that interface is saying already.  I guess you
could want to implement your own alsa kernel interface if you really
want to :)

Anyway, I've added more wording here for that, thanks.


> > +Every file in these directories will contain the following information:
> > +
> > +What:          Short description of the interface
> > +Created:       Date created
> 
> Perhaps also a line here specifying the first mainline kernel release
> (not -mm or -rc, but first stable kernel) that the interface is
> available with. ??

Good idea, added.

> > +It's up to the developer to place their interface in the category they
> > +wish for it to start out in.
> 
> In my oppinion it should be a requirement that an interface spends at
> least one kernel release in the "testing" state before moving to
> "stable" and can't be added to "stable" straight away.

Hm, good idea, syscalls should even do this...

thanks again for your input, I'll repost an updated version based on
these comments and the others.

greg k-h
