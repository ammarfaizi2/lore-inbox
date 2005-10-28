Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbVJ1M1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbVJ1M1A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 08:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbVJ1M07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 08:26:59 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:31183
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S965219AbVJ1M07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 08:26:59 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Date: Fri, 28 Oct 2005 07:26:56 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <4360C0A7.4050708@weizmann.ac.il> <200510271609.47309.rob@landley.net> <436211B0.1050509@weizmann.ac.il>
In-Reply-To: <436211B0.1050509@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510280726.56684.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 06:55, Evgeny Stambulchik wrote:
> Rob Landley wrote:
> > But no, this one's clearly a kernel error.  If the kernel is giving write
> > errors against the device afterwards, than the kernel's internal state
> > toggled successfully, which is all the mount syscall was trying to do. 
> > Mount is just reporting whether or not the syscall succeeded, not whether
> > or not it should have. :)
>
> OK, so there are actually two separate bugs, it seems: one that
> remounting a RO media in the RW mode succeeds (this "works" for any RO
> media, as far as I can tell) and the second (this one is specific to the
> floppy driver only) that a further write to such a falsely rw-remounted
> media doesn't return (in the user space) an error.

It looks like one bug to me.  The initial mount figures out that it's read 
only, and the actual writes fail correctly, but remount isn't checking for 
read only (and thus isn't failing).

Rob
