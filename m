Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWAWPef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWAWPef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWAWPef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:34:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48276 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751471AbWAWPee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:34:34 -0500
Date: Mon, 23 Jan 2006 15:34:28 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] device-mapper snapshot: load metadata on creation
Message-ID: <20060123153428.GH4280@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060120211116.GB4724@agk.surrey.redhat.com> <20060122213311.2aa12eb6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060122213311.2aa12eb6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 09:33:11PM -0800, Andrew Morton wrote:
> If people are using older tools and they run with this patch, what will
> happen to them?
 
The problem I have noticed is that in certain configurations LVM2 commands 
to deactivate a snapshot may fail part-way through and need to be completed
using dmsetup.

Deactivating snapshots before removing them seems to avoid that problem,
but it's not always feasible.

Example: 
  lvol1 is a snapshot of lvol0.  Both are active.
  You run 'lvremove vgg/lvol1' but the command hangs.
  Workaround: from another shell run 'dmsetup resume vgg-lvol1-cow' and
  the command then completes.

Having more than one snapshot of the same device can also lead to problems.

But without this patch and the updated LVM2 tools, whenever you run
'lvcreate -s' to create a snapshot you're taking the risk that the command 
will hang irrecoverably (leading you to want to reboot the machine even if 
it didn't panic).

Alasdair
-- 
agk@redhat.com
