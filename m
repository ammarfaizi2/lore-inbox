Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWC1X3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWC1X3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWC1X3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:29:33 -0500
Received: from thunk.org ([69.25.196.29]:10708 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964835AbWC1X3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:29:32 -0500
Date: Tue, 28 Mar 2006 18:29:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: e2label suggestions
Message-ID: <20060328232927.GB32385@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Jeff V. Merkey" <jmerkey@soleranetworks.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <4429AF42.1090101@soleranetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4429AF42.1090101@soleranetworks.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 02:48:50PM -0700, Jeff V. Merkey wrote:
> e2label takes as parms:
> 
> e2label <device name> <mount point>

Actually, it's label name, not "mount point".  Some
people/distributions will use a label name of "/" for the root
filesystem, but that is purely a convention.

> What's useless about this is the association of device name and file 
> system label which is completely broken on SATA systems which do dynamic
> assignment.  e2label was a great idea, but did not go far enough to 
> abstract. 

It's not an association of device name and file system label.  It is
an assignment of a filesystme label to a *filesystem*.  The label is
actually stored in the ext3's superblock.

> The Initial mount sequence using:
> 
> root=LABEL=/
> 
> should be modified to ignore the device assignment and dunamically scan 
> the drives for the root drive for initial bootup and DETECT
> the device assignment rather then reverting to fixed device 
> assignments.  As implemented it's pretty useless and is simply an aliasing
> mechanism rather than solving the problem of the system being truly 
> dynamic. 

You can do this, and on some distributions it does work that way; the
initial root device is actually an initrd, and the initrd will search
the drivers looking for the root drive.  The blkid library, or the
blkid program, can be used provide that functionality (indeed the
mount program, when passed the argument "LABEL=/" can be compiled to
use the blkid library to do this searching).

So it does (or at least can) work this way already, but it's all
userspace stuff which is currently distro-specific.  Which brings up
the question why you posted this on LKML....

						- Ted
