Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318858AbSH1OUN>; Wed, 28 Aug 2002 10:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSH1OUN>; Wed, 28 Aug 2002 10:20:13 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:27134 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S318858AbSH1OUM>; Wed, 28 Aug 2002 10:20:12 -0400
Date: Wed, 28 Aug 2002 09:24:23 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
Message-ID: <19220000.1030544663@baldur.austin.ibm.com>
In-Reply-To: <200208280009.03090.trond.myklebust@fys.uio.no>
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
 <shsvg5wqemp.fsf@charged.uio.no> <20020827200110.GB8985@tapu.f00f.org>
 <200208280009.03090.trond.myklebust@fys.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, August 28, 2002 12:09:03 AM +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> FYI a BSD ucred is basically a structure of the form
> 
> struct ucred {
> 	int	counter;		/* Reference counter */
> 	uid_t	uid;			/* task->fsuid */
> 	gid_t	gid;			/* task->fsgid */
> 	int	ngroups;		/* task->ngroups */
> 	gid_t	*groups;		/* task->groups */
> };

Shouldn't the Linux cred structure include the capabilities, as well?  What
about places that want to see both uid and euid?  Shouldn't euid/egid also
be in the structure?  I realize that for file operations they're not
strictly necessary, but we should make the structure useful across all
parts of the kernel that want to see credentials.

BTW, you've convinced me that your approach is the right way to go.  I'll
make another stab at CLONE_CRED after the VFS changes are made, which will
make it a 2.7 item, I'm sure.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

