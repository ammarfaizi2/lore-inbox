Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVBBRek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVBBRek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 12:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVBBRek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 12:34:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262306AbVBBReg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 12:34:36 -0500
Date: Wed, 2 Feb 2005 17:34:33 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Kristina Clair <kclair@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dm_snapshot experimental? potential repercussions?
Message-ID: <20050202173433.GC14097@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Kristina Clair <kclair@gmail.com>, linux-kernel@vger.kernel.org
References: <dff3752705020208024b5992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff3752705020208024b5992@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 11:02:49AM -0500, Kristina Clair wrote:
> I have been told that dm_snapshot is still experimental in the 2.6.10
> kernel, and I was advised not to have more than one snapshot created
> at a time for the same logical volume.
 
Each snapshot is independent and keeps its own separate copy of 
changes, so as you increase the number of parallel snapshots you
quickly affect performance.  This has always been the case for
LVM and device-mapper snapshots.  Daniel Phillips is working on a
clustered snapshot implementation which at the same time addresses 
this issue, allowing parallel snapshots to share their metadata.

> Basically I am just wondering what the potential problems are with
> dm_snapshot.  Is there anything particular that I should look out for?

There are numerous memory allocation issues with the current dm-snapshot 
implementation: in simple terms, devices or your machine can lock up,
and your system is especially vulnerable when snapshots are manipulated
(create/activate) and when your system is under load.

We think we understand the most important problems and are gradually 
fixing them, but this is not a quick process because the changes have a 
significant impact on the LVM2 and EVMS code bases (complex sequences of 
ioctls have to change).

Join the dm-devel mailing list if you want to monitor progress.
 
Alasdair
-- 
agk@redhat.com
