Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWHVEUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWHVEUy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 00:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWHVEUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 00:20:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751153AbWHVEUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 00:20:54 -0400
Date: Mon, 21 Aug 2006 21:20:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Jan Beulich" <jbeulich@novell.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-Id: <20060821212043.332fdd0f.akpm@osdl.org>
In-Reply-To: <20060821094718.79c9a31a.rdunlap@xenotime.net>
References: <20060820013121.GA18401@fieldses.org>
	<44E97353.76E4.0078.0@novell.com>
	<20060821094718.79c9a31a.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 09:47:18 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> > The 'stuck' unwinder issue at hand already has a fix, though planned to
> > be merged for 2.6.19 only. The crash after switching to the legacy
> > stack trace code is bad, though, but has little to do with the unwinder
> > additions/changes. The way that code reads the stack is just
> > inappropriate in contexts where things must be expected to be broken.
> 
> "merged for 2.6.19" meaning:
> - in (before) 2.6.19, or
> - after 2.6.19 is released
> 
> If "after," then it will likely need to be added to -stable also,
> so it might as well go in "before" 2.6.19 is released.

Precisely.

Guys, this unwinder change has been quite problematic.  We really cannot
let this badness out into 2.6.18 - it degrades our ability to debug every
subsystem in the entire kernel.  Would marking it CONFIG_BROKEN get us back
to 2.6.17 behaviour?

Has anyone even tried to reproduce Bruce's crash?

<looks>

argh, ide-scsi.  That driver's main use nowadays is for testing the
oops-handling code.  Please share .config, machine description and compiler
versiom.

