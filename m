Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbUDGGoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbUDGGoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:44:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30920 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263675AbUDGGoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:44:03 -0400
Date: Wed, 7 Apr 2004 07:44:03 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040407064402.GP31500@parcelfarce.linux.theplanet.co.uk>
References: <20040406145544.GA19553@MAIL.13thfloor.at> <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk> <20040406231136.GN31500@parcelfarce.linux.theplanet.co.uk> <20040407003506.A18559@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407003506.A18559@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 12:35:06AM +0100, Russell King wrote:
> I believe its so that we update the data in the cache, and avoid writing
> it back to disk unnecessarily - consider the case where you have a lot
> of tty activity (which updates atime).  You don't particularly want to
> be committing atime updates to disk every, what, 5 seconds, or performing
> the NFS operations for the same.

OK, but at least we want to dirty the inode at some point (e.g. final
close), so that atime would be monotonous - as it is, we get it reset
when inode goes out of cache and is reread again...
