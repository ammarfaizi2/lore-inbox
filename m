Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUCHGgn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 01:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbUCHGgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 01:36:42 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:49951 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262415AbUCHGgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 01:36:40 -0500
Date: Mon, 8 Mar 2004 00:36:39 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Some highmem pages still in use after shrink_all_memory()?
Message-ID: <20040308063639.GA20793@hexapodia.org>
References: <20040307144921.GA189@elf.ucw.cz> <20040307164052.0c8a212b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040307164052.0c8a212b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 04:40:52PM -0800, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> > For swsusp, I need to free as much memory as possible. Well, and it
> > would be great if no highmem pages remained, so that I would not have
> > to deal with that. Is that possible?
> 
> No, it isn't.  There are pagetable pages and mlocked user pages which we
> cannot do anything with.
> 
> We could perhaps swap out the mlocked pages anyway if a suspend is in
> progress, but the highmem pagetable pages are not presently reclaimed
> by the VM.

Note that there are some applications for which it is a *bug* if an
mlocked page gets written out to magnetic media.  (gpg, for example.)
I imagine that they'd rather lose the mapping and get a page fault on
the next reference (which they can then fix up with a new mmap and
mlock) than have precious key material written to disk.

... unless, of course, the swap device is securely encrypted a la
OpenBSD's 'sysctl vm.swapencrypt.enable'.

http://www.openbsd.org/papers/swapencrypt.ps

However, I don't see how to implement a cryptographically secure swsusp.

(The importance of this behavior is obviously dependent on your threat
model.  Perhaps the Sufficiently Paranoid gpg users will simply need to
avoid using swsusp.)

-andy
