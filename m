Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVFOEvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVFOEvC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 00:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFOEvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 00:51:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261489AbVFOEu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 00:50:56 -0400
Date: Tue, 14 Jun 2005 21:50:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is one sync() not enough?
Message-Id: <20050614215032.35d44e93.akpm@osdl.org>
In-Reply-To: <20050614094141.GE1467@schottelius.org>
References: <20050614094141.GE1467@schottelius.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius <nico-kernel@schottelius.org> wrote:
>
> Hello again!
> 
> When my system shuts down and init calls sync() and after that
> umount and then reboot, the filesystem is left in an unclean state.
> 
> If I do sync() two times (one before umount, one after umount) it
> seems to work.
> 

That's a bug.

The standards say that sync() is supposed to "start" I/O, or something
similarly vague and waffly.  The Linux implementation of sync() has always
started all I/O and then waited upon all of it before returning from
sync().

And umount() itself will sync everything to disk, so the additional sync()
calls should be unnecessary.

That being said, if umount was leaving dirty filesystems then about 1000000
people would be complaining.  So there's something unusual about your
setup.

What filesystem?  What kernel version?  Any unusual bind mounts, loopback
mounts, etc?  There must be something there...
