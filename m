Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVBKMoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVBKMoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 07:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVBKMoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 07:44:39 -0500
Received: from one.firstfloor.org ([213.235.205.2]:4483 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262130AbVBKMoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 07:44:37 -0500
To: Junfeng Yang <yjf@stanford.edu>
Cc: mc@cs.Stanford.EDU, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] Does sys_sync (ext2, 2.6.x) flush metadata?
References: <Pine.GSO.4.44.0502102345540.8091-100000@elaine24.Stanford.EDU>
From: Andi Kleen <ak@muc.de>
Date: Fri, 11 Feb 2005 13:44:34 +0100
In-Reply-To: <Pine.GSO.4.44.0502102345540.8091-100000@elaine24.Stanford.EDU> (Junfeng
 Yang's message of "Thu, 10 Feb 2005 23:59:53 -0800 (PST)")
Message-ID: <m1wttfuuz1.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> writes:

> We're working on a file system checker and have a question regarding what
> sys_sync actually does.  It appears to us that sys_sync should sync both
> data and metadata, and wait until both data and metadata hit the disk
> before it returns.  Is this true for all the file systems (especially
> ext2) for kernel 2.6.x?  I've gotten many "error" traces for ext2, where
> directory entries are not flushed to disk after sys_sync.  In other words,
> even if users do call sys_sync, a crash after sys_sync call can still
> cause file losses.  Is this intended?

No, it would be a bug. sync() is supposed to flush everything.
In the ext2 case directory changes should be hold in a dirty buffer,
which sync should normally flush.

-Andi
