Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTJ1AU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 19:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbTJ1AU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 19:20:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263786AbTJ1AU2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 19:20:28 -0500
Date: Tue, 28 Oct 2003 00:20:25 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Iustin Pop <iusty@k1024.org>, linux-kernel@vger.kernel.org
Subject: Re: inode->i_rdev not initialized in 2.4 fs/inode.c, only in 2.6?
Message-ID: <20031028002025.GX7665@parcelfarce.linux.theplanet.co.uk>
References: <20031027234514.GA11213@saytrin.hq.k1024.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027234514.GA11213@saytrin.hq.k1024.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 01:45:14AM +0200, Iustin Pop wrote:
> Hello,
> 
> I'm running 2.4.22 (with XFS and skas patch), but these patches do not
> affect the code in question. /proc/version = Linux version 2.4.22-xfs
> (root@saytrin) (gcc version 3.3.2 20030908 (Debian prerelease))
> 
> I get strange results (st.st_rdev != 0) in userspace after stat on some
> non-devices regular file/directory. On one computer, /etc gives 773 and
> /etc/init.d 0, while on another /etc gives 0 and /etc/init.d 13478.

st_rdev is undefined for non-devices, so any userland code that relies on
it being zero is broken.  It wouldn't hurt to zero it out, but any application
that has problems with that needs to be fixed anyway.
