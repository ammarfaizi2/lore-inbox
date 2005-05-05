Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVEEU7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVEEU7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 16:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVEEU7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 16:59:53 -0400
Received: from thunk.org ([69.25.196.29]:62874 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261800AbVEEU7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 16:59:52 -0400
Date: Thu, 5 May 2005 16:59:49 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: does e2fsprogs needs to invoke file system related system calls?
Message-ID: <20050505205949.GA7442@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
References: <4ae3c1405050513493b5a1b88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c1405050513493b5a1b88@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 04:49:33PM -0400, Xin Zhao wrote:
> does e2fsprogs needs to invoke file system related system calls?
> 
> The reason I want to ask this question is to know whether we can
> bypass the system call monitoring based access control with e2fsprogs.

You'll need to be more specific about exactly what you are asking and
why.  Of *course* e2fsprogs needs to invoke filesystem related system
calls.  Just to give a few examples: e2fsck uses the blkid library to
map from a LABEL specifier to a device, and this libblkid will open
and read /etc/blkid.tab; e2fsck will open and read the /etc/mtab file
to make sure it is not checking a mounted filesystem; e2fsck will need
to open the block device and then read and write from said block
device.  If libntl are in use, then of course e2fsprogs will have to
open and read the translation files from the filesystem --- and this
is just the surface.

							- Ted
