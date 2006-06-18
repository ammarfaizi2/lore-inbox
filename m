Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWFRTQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWFRTQa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWFRTQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:16:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22462 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932290AbWFRTQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:16:30 -0400
Date: Sun, 18 Jun 2006 20:16:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] Implement AT_SYMLINK_FOLLOW flag for linkat
Message-ID: <20060618191629.GE27946@ftp.linux.org.uk>
References: <200606171913.k5HJDM3U021408@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606171913.k5HJDM3U021408@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 03:13:22PM -0400, Ulrich Drepper wrote:
> When the linkat() syscall was added the flag parameter was added in the
> last minute but it wasn't used so far.  The following patch should
> change that.  My tests show that this is all that's needed.
> 
> If OLDNAME is a symlink setting the flag causes linkat to follow the
> symlink and create a hardlink with the target.  This is actually
> the behavior POSIX demands for link() as well but Linux wisely does
> not do this.  With this flag (which will most likely be in the next
> POSIX revision) the programmer can choose the behavior, defaulting
> to the safe variant.  As a side effect it is now possible to implement
> a POSIX-compliant link(2) function for those who are interested.

Where does POSIX require that?  IIRC, it was along the lines of "application
can't rely on kernel doing the right thing", not "kernel must do the
wrong thing"...
