Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270986AbTGVSja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270987AbTGVSja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:39:30 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:61312 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270986AbTGVSj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:39:29 -0400
Date: Tue, 22 Jul 2003 20:04:16 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307221904.h6MJ4Gnr001119@81-2-122-30.bradfords.org.uk>
To: herbert@13thfloor.at
Subject: Re: noaltroot bootparam [was Floppy Fallback]
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       trond.myklebust@fys.uio.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trond suggested to draft a patch to address the
> Floppy Fallback issues (mentioned several times
> on lkml) by adding a kernel boot parameter, to
> disable the fallback, or to put it more general,
> to disable alternate root device attempts ...
>
> Currently the NFS-Root Floppy Fallback is the 
> only _user_ of such a boot parameter, but in 
> future, this could be used to limit multiple
> root situations to a make-or-brake ...
>
> please comment!

I think the best thing to do if it's not possible to mount an
NFS-based root filesystem, is to wait 60 seconds, then try to contact
the NFS server again.

Before the in-kernel bootloader was removed, the current behavior was
quite useful - it was quite possible that a hard disk-less machine
would boot from a floppy without using a bootloader, and mount it's
root filesystem from an NFS server.  In this scenario, it would be
impossible to boot the machine with the root on another device,
without modifying the boot disk, so a fallback to root on a floppy was
useful.

However, the in-kernel bootloader was removed in 2.6, so there is now
no reason why an alternate root couldn't simply be specified at the
boot prompt.

If the NFS server is not accessible because of a temporary problem,
(too much network traffic, or it's rebooting for example), it makes
sense to try again after 60 seconds.

Not trying the floppy should become the _default_ action.

John.
