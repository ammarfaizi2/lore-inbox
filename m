Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWBYJQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWBYJQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 04:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWBYJQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 04:16:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34797 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932627AbWBYJQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 04:16:09 -0500
Date: Sat, 25 Feb 2006 09:16:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] flags parameter for linkat
Message-ID: <20060225091606.GA22749@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ulrich Drepper <drepper@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <200602231410.k1NEAMk1021578@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602231410.k1NEAMk1021578@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 09:10:22AM -0500, Ulrich Drepper wrote:
> I'm currently at the POSIX meeting and one thing covered was the
> incompatibility of Linux's link() with the POSIX definition.  The
> difference is the treatment of symbolic links in the destination
> name.  Linux does not follow symlinks, POSIX requires it does.
> 
> Even somebody thinks this is a good default behavior we cannot
> change this because it would break the ABI.  But the fact remains
> that some application might want this behavior.
> 
> We have one chance to help implementing this without breaking the
> behavior.  For this we could use the new linkat interface which
> would need a new flags parameter.  If the new parameter is
> AT_SYMLINK_FOLLOW the new behavior could be invoked.
> 
> I do not want to introduce such a patch now.  But we could add the
> parameter now, just don't use it.  The patch below would do this.
> Can we get this late patch applied before the release more or less
> fixes the syscall API?

Please stop adding these crappy flags argument everywhere, they're also
creaping like a cancer through the other *at stuff.  Just make linkat
do the righ thing per posix spec for link, and then you can implement
a posix link based on it in glibc if the user compiles with XOPEN_SOURCE
or whatever.
