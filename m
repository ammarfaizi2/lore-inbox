Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbRFEEIa>; Tue, 5 Jun 2001 00:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263201AbRFEEIV>; Tue, 5 Jun 2001 00:08:21 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:21002 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S263193AbRFEEIJ>;
	Tue, 5 Jun 2001 00:08:09 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.23395.553496.50934@argo.ozlabs.ibm.com>
Date: Tue, 5 Jun 2001 14:09:07 +1000 (EST)
To: Adrian Bunk <bunk@fs.tum.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
In-Reply-To: <Pine.NEB.4.33.0106022224480.6994-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <20010530003001.A2864@bacchus.dhis.org>
	<Pine.NEB.4.33.0106022224480.6994-100000@mimas.fachschaften.tu-muenchen.de>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:

> (my main concern wasn't whether the "#ifdef __KERNEL__" is correct or not
> but I was wondering whether there's a reason why it's different on
> different architectures)

The only valid reason for userspace programs to be including kernel
headers is to get definitions that are part of the kernel API.  (And
in fact others here will go further and assert that there are *no*
valid reasons for userspace programs to include kernel headers.)

If you want some atomic functions or whatever for your userspace
program and the ones in the kernel look like they would be useful,
then take a copy of the relevant kernel code if you like, but don't
include the kernel headers directly.  If you do, you will get bitten
at some point in the future when we decide to change some internal
implementation detail in the kernel, and your program suddenly won't
compile any more.

This is why I added #ifdef __KERNEL__ around most of the contents
of include/asm-ppc/*.h.  It was done deliberately to flush out those
programs which are depending on kernel headers when they shouldn't.

Paul.
