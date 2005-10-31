Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVJaXR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVJaXR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVJaXR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:17:27 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:50843
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S964866AbVJaXR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:17:26 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: [PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk
Date: Mon, 31 Oct 2005 17:17:21 -0600
User-Agent: KMail/1.8
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
References: <4363B081.7050300@jonmasters.org> <35fb2e590510291035n297aa22cv303ae77baeb5c213@mail.gmail.com> <43660693.6040601@weizmann.ac.il>
In-Reply-To: <43660693.6040601@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311717.21676.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 05:57, Evgeny Stambulchik wrote:
> Jon Masters wrote:
> > Let me know if this fixes it for you - should bomb out now if you try.
> > The error isn't the cleanest (blame mount), but it does fail.
>
> This works fine, thanks! For what it worth, though, mount -o remount,rw
> says remounting read-only yet still returns success. (Opposite to
> busybox, which now says "Permission denied" - rather misleading, but at
> least it fails).

That sounds like the string translation of EPERM returned by libc's 
strerror().  (At busybox we're frugal bastards; we don't include text 
messages when we can get the C library to provide them for us. :)

But yeah, we're sticklers for correct behavior, and only attempt to remount 
readonly if we get EACCES or EROFS, not _just_ because we attempted a 
read/write mount and it failed.  (And yes, I personally tested this corner 
case.  We haven't started on an automated regression test script for mount 
yet because running it would require root access, but it's on the todo list 
as we upgrade the test suite in our Copious Free Time...)

Rob
