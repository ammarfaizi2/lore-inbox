Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUHVVWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUHVVWm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUHVVWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:22:42 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:4256 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S264704AbUHVVWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:22:39 -0400
To: Pascal Schmidt <der.eremit@email.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <2ptdY-42Y-55@gated-at.bofh.it> <2uPdM-380-11@gated-at.bofh.it>
	<2uUwL-6VP-11@gated-at.bofh.it> <2uWfh-8jo-29@gated-at.bofh.it>
	<2uXl0-Gt-27@gated-at.bofh.it> <2vge2-63k-15@gated-at.bofh.it>
	<2vgQF-6Ai-39@gated-at.bofh.it> <2vipq-7O8-15@gated-at.bofh.it>
	<2vj2b-8md-9@gated-at.bofh.it> <2vDtS-bq-19@gated-at.bofh.it>
	<E1ByXMd-00007M-4A@localhost> <412770EA.nail9DO11D18Y@burner>
	<412889FC.nail9MX1X3XW5@burner>
	<Pine.LNX.4.58.0408221450540.297@neptune.local>
From: Julien Oster <lkml-7994@mc.frodoid.org>
Organization: FRODOID.ORG
Mail-Followup-To: Pascal Schmidt <der.eremit@email.de>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Date: Sun, 22 Aug 2004 23:27:44 +0200
In-Reply-To: <Pine.LNX.4.58.0408221450540.297@neptune.local> (Pascal
 Schmidt's message of "Sun, 22 Aug 2004 15:13:37 +0200 (CEST)")
Message-ID: <871xhy3ltb.fsf@killer.ninja.frodoid.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt <der.eremit@email.de> writes:

Hello Pascal,

> The open question is whether write permission really is meaningful
> enough to allow arbitrary SCSI commands. I personally think "being
> able to wipe the drive firmware" is too much, and since filtering
> of vendor commands is generally impossible to do right, sending SG_IO
> should require CAP_SYS_RAWIO capability.

But what about the following (the first 3 points are already
familiar):

1. require read permission to do read()
2. require write premission to do write()
3. require CAP_SYS_RAWIO to do SG_IO
4. insert an initially blank (i.e. "drop everything") userspace
   controllable filter which allows the administrator to specify
   allowed SG_IO commands to the kernel at any time

That way there is no security problem, CD burning as root or generally
with CAP_SYS_RAWIO is always possible *and* admins are able to submit a
list of allowed commands to the kernel, so that CD burning as user is
possible again. This list might be specific to the CD writer hardware,
as we learned that some drives require vendor specific commands.

Prewritten filter lists for specific hardware can be published on
internet or even be submitted by cdrecord or other burning software,
i.e. with a switch "--install-filter" as root.

The filters should be separate for each SCSI device, so that you won't
enable dangerous commands on harddisk partitions when you just wanted
to enable CD burning.

If nobody else volunteers, I'll see if I can prepare a patch. I guess
sysfs is the right place for the userspace interface to the filters?

Regards,
Julien
