Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263221AbVCDXnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbVCDXnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbVCDXlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:41:09 -0500
Received: from peabody.ximian.com ([130.57.169.10]:3972 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S263227AbVCDVqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:46:42 -0500
Subject: Re: [patch] inotify for 2.6.11
From: Robert Love <rml@novell.com>
To: "Timothy R. Chavez" <chavezt@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <f2833c7605030413386a61ecb0@mail.gmail.com>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
	 <f2833c7605030413386a61ecb0@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 16:40:33 -0500
Message-Id: <1109972433.4526.14.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 15:38 -0600, Timothy R. Chavez wrote:

Hi, Mr. Chavez.

> Are there plans of reworking the "generic" hooking infrastructure
> (fsnotify.h) to be more like the security hooking framework (+
> stacking)?  I think it'd be nice to be able to have a fs_notify struct
> of function pointers, point at the one's I've chosen to implement, and
> then register / unregister with the framework.  Maybe this is an
> overly complicated approach, but these don't seem like they're generic
> hooks in anyway.

Personally, I think it is overkill.  I don't think we are going to have
the myriad of file notification systems that we have for security layers
(indeed, the goal is to have just inotify).

That said, we could always make the layer more pluggable once inotify is
in.  I would not fight that.  But, personally I don't see any real
benefit, just additional complexity and overhead.

> + * include/linux/fs_notify.h - >generic< hooks for filesystem notification, to
> + * reduce in-source duplication from both >dnotify and inotify<.
> 
> I guess I don't fully understand that comment.  Just quickly glancing
> at it, all you've done is added a level of indirection and shifted the
> same redundant code from the VFS to fs_notify.h -- Please correct me
> if I'm wrong (not at all uncommon).

No, you are right.  The "generic" part is supposed to be what is in the
VFS.  E.g., the fsnotify_foo() calls are supposed to be the generic
interface.

The body of these calls, as you can see, is static code, a simple copy
and cleanup of the inotify + dnotify hooks.

The idea, spurred by Christoph Hellwig's suggestion, was to keep the VFS
clean.  Not make a super neat pluggable notification system.  I think
the layers ARE generic, though, in the sense that foonotify could
probably drop some static code into fsnotify.h and work.

> As you already know, there's work being done on the audit subsystem
> that also needs notifications from the filesystem and would require
> yet another set of hooks.  However, where we get notified might differ
> from where inotify and dnotify get notified and it seems like
> fs_notify is tailored specifically for inotify (and accommodates
> dnotify out of obligation) and openly implements the "generic" hooks
> it requires.
> 
> Regardless, if this is the way it's going to be done.  We'll expand
> fs_notify.h to meet our needs as well.

If we end up duplicating stuff and making a big mess, then the audit
layer and the notification layer should DEFINITELY look at merging and
consolidating.  But I think that we need to wait until one or the other
gets more traction and into the mainline kernel.

> Also, FYI: 
> I just purchased the 2nd edition of your book, looking forward to reading it.

Great.  Hope you enjoy it!  ;-)

Best,

	Robert Love


