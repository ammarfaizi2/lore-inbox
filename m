Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVDGSqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVDGSqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVDGSqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:46:21 -0400
Received: from ns1.coraid.com ([65.14.39.133]:32579 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S262548AbVDGSqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:46:12 -0400
To: Christoph Hellwig <hch@infradead.org>
CC: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of
 AOE_PARTITIONS from Kconfig
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
	<1111677688.29912@geode.he.net> <20050328170735.GA9567@infradead.org>
	<87hdiuv3lz.fsf@coraid.com> <20050329162506.GA30401@infradead.org>
	<87wtrqtn2n.fsf@coraid.com> <20050329165705.GA31013@infradead.org>
From: Ed L Cashin <ecashin@coraid.com>
Date: Thu, 07 Apr 2005 14:28:59 -0400
In-Reply-To: <20050329165705.GA31013@infradead.org> (Christoph Hellwig's
 message of "Tue, 29 Mar 2005 17:57:05 +0100")
Message-ID: <8764yywidw.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Mar 29, 2005 at 11:48:48AM -0500, Ed L Cashin wrote:
>> I don't know if it matters now that we have udev.  When udev manages
>> the device nodes it all just works,
>
> But most peopel still don't use udev.
>
>> If you're saying that it's bad in principal, then that's another
>> story.  If that's what you mean, then it's a Linux policy issue, and
>> to follow convention I'd think that we'd need another major number.
>> That would be like the partitionable md devices, etc.
>
> Yes, it's a policy issue.  We don't do this weird config option anywhere
> else.

A couple support calls later, I think I've come around to your point
of view.  This patch isn't needed and may cause confusion.

Few aoe users really use partitions on their aoe disks, so I can make
the aoe driver have one minor number per disk as the default to avoid
the most common problems people encounter.

Then, aoe users who really need to partition their network disks can
use the partitionable md driver to "wrap" the aoe disk, like this:

  mdadm -B -l linear --force -n 1 --auto=mdp /dev/md_p0 /dev/etherd/e7.0
  fdisk /dev/md_p0


-- 
  Ed L Cashin <ecashin@coraid.com>

