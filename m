Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVKACgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVKACgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 21:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVKACgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 21:36:44 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:57409 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964930AbVKACgn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 21:36:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rUM6uRe85HTOGs/fcumwCOuzTWkPsq/MGFe3+8krzcLAmNQKd5ca3TilOd2QRoWfb9HjpfqvdzXKsufpGqppthvM82Jp0QPj78eg4Xb87CC7n+NlVMTXjdRmknQSe2k+noV8x93VZ4HPvts/1fV0vQ7KJIveORjI0fICGnF3izc=
Message-ID: <35fb2e590510311836j4c7fbdf2u77a72ebbfd53790c@mail.gmail.com>
Date: Tue, 1 Nov 2005 02:36:42 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Rob Landley <rob@landley.net>
Subject: Re: [PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk
Cc: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200510311717.21676.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4363B081.7050300@jonmasters.org>
	 <35fb2e590510291035n297aa22cv303ae77baeb5c213@mail.gmail.com>
	 <43660693.6040601@weizmann.ac.il> <200510311717.21676.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/05, Rob Landley <rob@landley.net> wrote:
> On Monday 31 October 2005 05:57, Evgeny Stambulchik wrote:
> > Jon Masters wrote:
> > > Let me know if this fixes it for you - should bomb out now if you try.
> > > The error isn't the cleanest (blame mount), but it does fail.
> >
> > This works fine, thanks! For what it worth, though, mount -o remount,rw
> > says remounting read-only yet still returns success. (Opposite to
> > busybox, which now says "Permission denied" - rather misleading, but at
> > least it fails).
>
> That sounds like the string translation of EPERM returned by libc's
> strerror().  (At busybox we're frugal bastards; we don't include text
> messages when we can get the C library to provide them for us. :)

Indeed. Reminds me that I should clean up and send a form parser I
wrote for busybox to handle multi-part mime form posts in its
webserver while I'm at it. That's something it could do with even if
it's being frugal.

> But yeah, we're sticklers for correct behavior, and only attempt to remount
> readonly if we get EACCES or EROFS, not _just_ because we attempted a
> read/write mount and it failed.  (And yes, I personally tested this corner
> case.  We haven't started on an automated regression test script for mount
> yet because running it would require root access, but it's on the todo list
> as we upgrade the test suite in our Copious Free Time...)

You looked at running this inside a qemu environment (scratchbox), huh?

Jon.
