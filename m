Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263224AbVCDXnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbVCDXnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbVCDXlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:41:22 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:4296 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263232AbVCDVjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:39:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cU4kQORkQRchj8R5oguH276wMyidHvkTQaPcCzV6huXd26/hvYtfu84SoXD9G+LtfBrxV9GkgEsVgkw9P/mBco6EFfax7b1765m23+XaCphIHBEzer5i/73dYp9T63eUeXmTow27blT754R8syUC+7NQZYFBXSvEAodvtWagNUI=
Message-ID: <f2833c7605030413386a61ecb0@mail.gmail.com>
Date: Fri, 4 Mar 2005 15:38:58 -0600
From: "Timothy R. Chavez" <chavezt@gmail.com>
Reply-To: "Timothy R. Chavez" <chavezt@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] inotify for 2.6.11
Cc: Robert Love <rml@novell.com>
In-Reply-To: <1109961444.10313.13.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2005 13:37:24 -0500, Robert Love <rml@novell.com> wrote:
> Below is inotify, diffed against 2.6.11.
> 
> I greatly reworked much of the data structures and their interactions,
> to lay the groundwork for sanitizing the locking.  I then, I hope,
> sanitized the locking.  It looks right, I am happy.  Comments welcome.
> I surely could of missed something.  Maybe even something big.
> 
> But, regardless, this release is a huge jump from the previous, fixing
> all known issues and greatly improving the locking.
> 
> Best,
> 
>         Robert Love

Hey Robert,

Are there plans of reworking the "generic" hooking infrastructure
(fsnotify.h) to be more like the security hooking framework (+
stacking)?  I think it'd be nice to be able to have a fs_notify struct
of function pointers, point at the one's I've chosen to implement, and
then register / unregister with the framework.  Maybe this is an
overly complicated approach, but these don't seem like they're generic
hooks in anyway.

+ * include/linux/fs_notify.h - >generic< hooks for filesystem notification, to
+ * reduce in-source duplication from both >dnotify and inotify<.

I guess I don't fully understand that comment.  Just quickly glancing
at it, all you've done is added a level of indirection and shifted the
same redundant code from the VFS to fs_notify.h -- Please correct me
if I'm wrong (not at all uncommon).

As you already know, there's work being done on the audit subsystem
that also needs notifications from the filesystem and would require
yet another set of hooks.  However, where we get notified might differ
from where inotify and dnotify get notified and it seems like
fs_notify is tailored specifically for inotify (and accommodates
dnotify out of obligation) and openly implements the "generic" hooks
it requires.

Regardless, if this is the way it's going to be done.  We'll expand
fs_notify.h to meet our needs as well.

Also, FYI: 
I just purchased the 2nd edition of your book, looking forward to reading it.

<snip>

-- 
- Timothy R. Chavez
