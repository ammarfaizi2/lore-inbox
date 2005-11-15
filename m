Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVKODhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVKODhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVKODhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:37:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43954 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932345AbVKODhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:37:23 -0500
Date: Mon, 14 Nov 2005 19:37:15 -0800
From: Paul Jackson <pj@sgi.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-Id: <20051114193715.1dd80786.pj@sgi.com>
In-Reply-To: <20051115022931.GB6343@sergelap.austin.ibm.com>
References: <20051114212341.724084000@sergelap>
	<20051114153649.75e265e7.pj@sgi.com>
	<20051115010155.GA3792@IBM-BWN8ZTBWAO1>
	<20051114175140.06c5493a.pj@sgi.com>
	<20051115022931.GB6343@sergelap.austin.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge wrote:
> the vserver model

What's that?

> Unfortunately that would not work for checkpoints across boots,

That could be made to work, by an early init script that looked in the
"checkedpointed tasks storage locker" on disk, and reserved any pid's
used therein, marking them as frozen.  A little care can ensure that
no task with such a pid is already running.

> or, more importantly, for process (set) migration.

Migration to a system that has already been up a while, where no
reservation of pid's was made ahead of time, hence where pid's overlap,
would not work with my EFROZEN scheme - you are right there.

How large is our numeric pid space (on 64 bit systems, anyway)?  If
large enough, then reservation of pid ranges becomes an easy task.  If
say we had 10 bits to spare, then a server farm could pre-ordain say a
thousand virtual servers, which come and go on various hardware
systems, each virtual server with its own hostname, pid-range, and
other such paraphernalia.

However there is an elephant in the room, or a camel outside the tent
or some such.  Yes, the camel's nose may well fit inside the tent,
but before we invite his nose, we should have some idea if the rest
of the camel will fit.

In other words, since I don't see any compelling reason for this
virtualization of pids -except- for checkpoint/restart sorts of
features, the usefulness of pid virtualization would seem to rest on
the acceptability of the rest of the checkpoint/restart proposal.

For all I know now (not much) the amount of effort required to
sufficiently virtualize all the elements of the Linux kernel-user
interface enough to enable robust job migration across machines and
reboots may well make virtualizing the kernel's address space look easy.
Linux is not VM.

Hence, until sold on the larger direction, I am skeptical of this
first step.

Though, I will grant, I am interested too.  A good Linux
checkpoint/restart solution would be valuable.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
