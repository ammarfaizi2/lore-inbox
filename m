Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbTEaH6a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbTEaH6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:58:30 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:58563 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264212AbTEaH6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:58:30 -0400
Date: Sat, 31 May 2003 10:11:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "David S. Miller" <davem@redhat.com>
Cc: jmorris@intercode.com.au, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, kernel@kolivas.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030531081129.GA26179@wohnheim.fh-wedel.de>
References: <20030531064851.GA20822@wohnheim.fh-wedel.de> <20030530.235505.23020750.davem@redhat.com> <20030531075615.GA25089@wohnheim.fh-wedel.de> <20030531.005909.68051039.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030531.005909.68051039.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003 00:59:09 -0700, David S. Miller wrote:
> 
> You can't leave the per-cpu workspace in an indeterminate
> state, you'll context switch and meanwhile that workspace will
> be used by another client or you'll next get scheduled on
> a different cpu and use a different workspace.

Did you read the patch?

When getting scheduled, the workspace remains associated with the
owning process ( z->workspace, z->ws_num ).  Other processes trying to
grab a workspace will get put on a waitqueue ( zlib_workspace_sem ).

The workspace is not exactly per cpu, it is per process.  Just the
amount of workspaces happens to be equal to the amount of cpus in the
system, but a couple more or less should work just as well.  

In softirq context you would be right.  Preempt is disabled anyway and
cpu affinity comes for free.

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
