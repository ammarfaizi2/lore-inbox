Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWAWUs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWAWUs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWAWUs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:48:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25760 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932415AbWAWUsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:48:25 -0500
Date: Mon, 23 Jan 2006 21:48:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] device-mapper snapshot: fix invalidation
Message-ID: <20060123204810.GA1739@elf.ucw.cz>
References: <20060120213457.GJ4724@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060120213457.GJ4724@agk.surrey.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 20-01-06 21:34:57, Alasdair G Kergon wrote:
> When a snapshot becomes invalid, s->valid is set to 0.
> In this state, a snapshot can no longer be accessed.
> 
> When s->lock is acquired, before doing anything else, s->valid must be
> checked to ensure the snapshot remains valid.
> 
> This patch eliminates some races (that may cause panics) by adding
> some missing checks.  At the same time, some unnecessary levels of
> indentation are removed and snapshot invalidation is moved into a
> single function that always generates a device-mapper event.
> 
> Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

> +static void __invalidate_snapshot(struct dm_snapshot *s, struct pending_exception *pe, int err)
> +{
> +	if (!s->valid)
> +		return;
> +
> +	if ((err == -EIO))
> +		DMERR("Invalidating snapshot: Error reading/writing.");
> +	else if ((err == -ENOMEM))

I see you are trying to make it look distinct from assignment,
but... please don't do this.
							Pavel

-- 
Thanks, Sharp!
