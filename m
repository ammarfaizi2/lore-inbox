Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbVKVRSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbVKVRSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVKVRSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:18:53 -0500
Received: from thunk.org ([69.25.196.29]:5251 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965020AbVKVRSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:18:52 -0500
Date: Tue, 22 Nov 2005 12:18:47 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122171847.GD31823@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Chris Adams <cmadams@hiwaay.net>, linux-kernel@vger.kernel.org
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net> <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511221650360.2763@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 04:55:08PM +0000, Anton Altaparmakov wrote:
> > That assumption is probably made because that's what POSIX and Single
> > Unix Specification define: "The st_ino and st_dev fields taken together
> > uniquely identify the file within the system."  Don't blame code that
> > follows standards for breaking.
> 
> The standards are insufficient however.  For example dealing with named 
> streams or extended attributes if exposed as "normal files" would 
> naturally have the same st_ino (given they are the same inode as the 
> normal file data) and st_dev fields.

Um, but that's why even Solaris's openat(2) proposal doesn't expose
streams or extended attributes as "normal files".  The answer is that
you can't just expose named streams or extended attributes as "normal
files" without screwing yourself.

Also, I haven't checked to see what Solaris does, but technically
their UFS implementation does actually use separate inodes for their
named streams, so stat(2) could return separate inode numbers for the
named streams.  (In fact, if you take a Solaris UFS filesystem with
extended attributs, and run it on a Solaris 8 fsck, the directory
containing named streams/extended attributes will show up in
lost+found.)

						- Ted
