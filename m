Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbTDGSbi (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbTDGSbi (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:31:38 -0400
Received: from almesberger.net ([63.105.73.239]:13062 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262846AbTDGSbh (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 14:31:37 -0400
Date: Mon, 7 Apr 2003 15:43:03 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030407154303.C19288@almesberger.net>
References: <20030407165009.13596.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407165009.13596.qmail@email.com>; from cgweav@email.com on Mon, Apr 07, 2003 at 11:50:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clayton Weaver wrote:
> If the client process subsequently flink()s to the inode, it is merely
> a zerocopy file copy.

As far as access to the data is concerned, yes. But there's also the
location of the file. E.g. this might enable you to fill somebody
else's quota, or, if distinct physical devices can be be covered by
the same file system, to access a physical device that would
otherwise not be available to you.

Example: I write some kind of RAID mounted at /world, that contains
my disk under /world/disk, and some Flash storage under /world/flash.
I protect /world/flash against writes by other people. If a
read-only FD could be turned into something writeable, some malicious
creature could "wear out" my Flash by writing to it a lot of times.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
