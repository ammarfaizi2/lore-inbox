Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRDJSHn>; Tue, 10 Apr 2001 14:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbRDJSHd>; Tue, 10 Apr 2001 14:07:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49836 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130768AbRDJSHT>;
	Tue, 10 Apr 2001 14:07:19 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15059.19402.886297.342293@pizda.ninka.net>
Date: Tue, 10 Apr 2001 11:07:06 -0700 (PDT)
To: ppetru@ppetru.net (Petru Paler)
Cc: Jakub Jelinek <jakub@redhat.com>, Dawson Engler <engler@csl.Stanford.EDU>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] amusing copy_from_user bug
In-Reply-To: <20010410135947.I3497@ppetru.net>
In-Reply-To: <200104101011.DAA29579@csl.Stanford.EDU>
	<20010410064128.C1169@devserv.devel.redhat.com>
	<20010410135947.I3497@ppetru.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petru Paler writes:
 > On Tue, Apr 10, 2001 at 06:41:28AM -0400, Jakub Jelinek wrote:
 > > some architectures don't care at all, because verify_area is a noop
 > > (sparc64).
 > 
 > Why (and how) is this?

On sparc64, the user lives in an entirely different address space.
The user cannot even generate addresses in kernel space.  Basically,
addresses are prefix'd by an 8-bit tag called an ASI (Address Space
Identifier), which tells the cpu which TLB context to use etc.
When running in user space or accessing user space in kernel mode
we make the cpu use the special userspace ASI.

In fact the user can be given the complete 32-bit or 64-bit virtual
address space, the kernel takes up none of it.

Later,
David S. Miller
davem@redhat.com
