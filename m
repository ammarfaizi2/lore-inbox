Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUI2OWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUI2OWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUI2OTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:19:55 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:37892 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268447AbUI2OQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:16:06 -0400
Date: Wed, 29 Sep 2004 15:16:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Discuss issues related to the xorg tree <xorg@freedesktop.org>,
       Christoph Hellwig <hch@infradead.org>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Message-ID: <20040929151601.A13135@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Discuss issues related to the xorg tree <xorg@freedesktop.org>,
	dri-devel <dri-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910409280854651581e2@mail.gmail.com> <20040929133759.A11891@infradead.org> <415AB8B4.4090408@tungstengraphics.com> <20040929143129.A12651@infradead.org> <415ABA34.9080608@tungstengraphics.com> <415AC2B3.6070900@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <415AC2B3.6070900@tungstengraphics.com>; from keith@tungstengraphics.com on Wed, Sep 29, 2004 at 03:12:03PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 03:12:03PM +0100, Keith Whitwell wrote:
> Thinking about it, it may not have been a problem of crashing, but rather that 
>   the behaviour visible from a program attempting to read (or poll) was 
> different with noop versions of these functions to NULL versions, and that was 
> causing problems.  This is 18 months ago, so yes, I'm being vague.
> 
> The X server does look at this file descriptor, which is where the problem 
> would have arisen, but only the gamma & maybe ffb drivers do anything with it.

Indeed, for read you're returning 0 now instead of the -EINVAL from common
code when no ->read is present.  I'd say the current drm behaviour is a bug,
but if X drivers rely on it.

Similar in poll your return 0 now while the generic code return
(POLLIN | POLLOUT | POLLRDNORM | POLLWRNORM) for fds without ->poll, and
again I'd say current drm behaviour could be considered a bug.

for ->flush there's no behaviour change of not supplying it.

