Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265030AbSJWOs7>; Wed, 23 Oct 2002 10:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265031AbSJWOs7>; Wed, 23 Oct 2002 10:48:59 -0400
Received: from 80-195-6-171.cable.ubr04.ed.blueyonder.co.uk ([80.195.6.171]:2692
	"EHLO sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S265030AbSJWOs6>; Wed, 23 Oct 2002 10:48:58 -0400
Date: Wed, 23 Oct 2002 15:54:57 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Russell Coker <russell@coker.com.au>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021023155457.L2732@redhat.com>
References: <20021023125907.G2732@redhat.com> <Pine.GSO.4.33.0210230942210.7042-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.33.0210230942210.7042-100000@raven>; from sds@tislabs.com on Wed, Oct 23, 2002 at 10:27:27AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 23, 2002 at 10:27:27AM -0400, Stephen Smalley wrote:
> On Wed, 23 Oct 2002, Stephen C. Tweedie wrote:
> > setfsuid() creates credentials which are _only_ applied to file
> > operations.  The namespace happens to be the same one that applies to
> > processes, but there's nothing that requires that to be the case

> Would we need a separate call for setting the SIDs to use for each
> "namespace", i.e. fs (for open, mkdir, mknod, and symlink calls), IPC
> (for semget, msgget, and shmget calls), process (for execve calls), and
> socket (for socket, connect, listen, sendmsg, and sendto calls, requiring
> two SIDs for send*)?

The BSD socket API already has a clean and extensible way of dealing
with multiple namespaces, so there's plenty of precedent about how to
do this without requiring multiple syscalls.

> While your approach would work for calls that take input SID parameters,
> what about the various calls that return SIDs either directly or via
> output SID parameters, e.g. extended forms of *stat, msgrcv, recvmsg,
> getpeername/accept plus new calls like (sem|shm|msg)sid and getsecsid?

Good question --- what is the reason you need these, and are other
security modules likely to need similar functionality?  If so, there's
an argument for new syscalls which take a credentials/sid area as a
return argument.

--Stephen
