Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVAZGo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVAZGo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 01:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVAZGo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 01:44:28 -0500
Received: from one.firstfloor.org ([213.235.205.2]:16350 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262362AbVAZGo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 01:44:26 -0500
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, spyro@f2s.com
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 26 Jan 2005 07:44:24 +0100
In-Reply-To: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com> (Anton
 Blanchard's message of "Wed, 26 Jan 2005 01:22:10 +1100")
Message-ID: <m1zmyw4rlj.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> writes:
>
> It is possible for one task to end up "owning" an mm from another - we
> have seen this with the procfs code when process 1 accesses
> /proc/pid/cmdline of process 2 while it is exiting.  Process 2 exits
> but does not tear its mm down. Later on process 1 finishes with the proc
> file and the mm gets torn down at this point.

IMHO that's the root bug. That sounds really dangerous and will likely
cause other problems because it is totally unexpected. How about fixing
/proc to not do this?

-Andi
