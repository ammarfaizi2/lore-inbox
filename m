Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUGMVDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUGMVDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUGMVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:03:11 -0400
Received: from thunk.org ([140.239.227.29]:64904 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265897AbUGMVDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:03:08 -0400
Date: Tue, 13 Jul 2004 17:02:54 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Waldo Bastian <bastian@kde.org>
Cc: kde-core-devel@kde.org, Tim Connors <tconnors@astro.swin.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: kconfig's file handling (was: XFS: how to NOT null files on fsck?)
Message-ID: <20040713210254.GG10783@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Waldo Bastian <bastian@kde.org>, kde-core-devel@kde.org,
	Tim Connors <tconnors@astro.swin.edu.au>,
	linux-kernel@vger.kernel.org
References: <20040713110520.GB8930@ugly.local> <200407131431.43478.bastian@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407131431.43478.bastian@kde.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 02:31:43PM +0200, Waldo Bastian wrote:
> 
> The sentiment among filesystem developers seem to be that they don't care if 
> they trash files as long as the filesystem itself remains in a consistent 
> state. This kind of dataloss is the result of that attitude, either go 
> complain with them if it bothers you, or use a filesystem that does it right.
> 

Ext3 with ordered writes (the default) gets this right. 

Unfortunately, cheating can give you better benchmark resuls, and some
people seem to care more about better benchmark results than silly
things like user's files not getting wiped.  For many workloads,
especially for user desktops, the disk bandwidth isn't saturated, and
given that most writes are asynchronous in nature, a faster write
benchmark for a particular filesystem or filesystme mode may not
translate into a user-visible difference.  So focusing on improved
write speeds at the cost of data robustness can very often be false
economy.

							- Ted
