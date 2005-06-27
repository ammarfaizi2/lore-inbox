Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVF0I6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVF0I6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVF0I6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:58:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36754 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261948AbVF0I6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:58:01 -0400
Date: Mon, 27 Jun 2005 09:57:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Alexander Zarochentcev <zam@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       reiserfs-list@namesys.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Message-ID: <20050627085755.GA5015@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>,
	Alexander Zarochentcev <zam@namesys.com>,
	Jeff Garzik <jgarzik@pobox.com>, reiserfs-list@namesys.com,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <200506221824.32995.zam@namesys.com> <20050622142947.GA26993@infradead.org> <42BA2ED5.6040309@namesys.com> <20050626164606.GA18942@infradead.org> <42BF3D6B.7000404@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BF3D6B.7000404@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 04:42:35PM -0700, Hans Reiser wrote:
> >I'm a bit confused about what you're saying here.  What does the 'vector'
> >in all these expressions mean?
> >  
> >
> Was your word, I thought, for the *_operation structures.

We tend to use the term operation vectors, yes.  But that's a different
terminology that doesn't mix up very well with the OO terminology.

> So, rather than having a hierarchy, in which we first select filesystem,
> and then select plugin, VFS should treat each plugin as though it was a
> filesystem, if I understand you.

Kinda.  The VFS doesn't have knowledge about what constitutes a file
system driver, we register filesystems only to know what routine to
call in on a mount with a particular filesystem type - the structure that
does describe a filesystem (struct file_system_type) thus is very small.
Starting from there the filesystem has always been able to use different
methods for different objects (that's something very different from the
vnode-based VFSes in the other UNIX variants).  

> Plugins and pluginids continue to exist
> with the exact same functionality, we just eliminate a function
> dereference for the *_operation structures. Let's see how it codes up in
> its details.

For the file and dir plugin that's pretty much that case.  What's more
problematic is your security plugins.  With LSM we alredy have an
infrastructure to provide pluggable access control.  If there actually
was an implementation of "security" (it's actually access control) for it
besides the default unix permission one it should move to an LSM.  You
could even make your lsm part of the reiser4 module and poke into reiser4
directly from a technical point of view.
