Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318510AbSH1BpG>; Tue, 27 Aug 2002 21:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318514AbSH1BpG>; Tue, 27 Aug 2002 21:45:06 -0400
Received: from h-64-105-35-65.SNVACAID.covad.net ([64.105.35.65]:32711 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318510AbSH1BpF>; Tue, 27 Aug 2002 21:45:05 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 27 Aug 2002 18:49:17 -0700
Message-Id: <200208280149.SAA07234@baldur.yggdrasil.com>
To: jaharkes@cs.cmu.edu
Subject: Re: Loop devices under NTFS
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002 at 13:26:44 -0400, Jan Harkes wrote:
>Not all filesystems use generic_read/generic_write. If they did we
>wouldn't need those calls in the fops structure.

	My loop.c patch supports files that do not provide
aops->{prepare,commit}_write (derived from changes by Jari Ruusu
and Andrew Morton).

	Christoph was arguing that even if the file provides
aops->{prepare,commit}_write, that there could be a problem using it.
I am looking for a clear example of that.  I don't see the problem
with using this facility if you first check that it is provided.

	However, thank you for correcting me about Coda.  I missed
that in the list of file system that do not appear to provide
{prepare,commit}_write for plain files.  I actually grepped around and
discussed this by email with Andrew Morton and Hugh Dickens on August
16th.  Looking back at that email now, the list of file systems that
my grepping around suggested lacked {prepare,commot}_write for
writable files was:

	       tmpfs
	       coda
	       intermezzo
	       ncpfs

Side note:
>Ofcourse the prepar_write/commit_write were introduced later on and
>perhaps it is possible to modify all filesystems to put all their
>custom functionality in these functions. Then we can simply remove the
>read and write (and mmap?) fops [...]

	You still need read and write methods at least for files that
are not seekable (e.g., serial devices, network sockets, pipes), but I
think you could conceivably have everything else use generic page
cache routines.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
