Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWDTRFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWDTRFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWDTRFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:05:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751148AbWDTRFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:05:39 -0400
Date: Thu, 20 Apr 2006 18:05:35 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: BUG at drivers/md/kcopyd.c:146 (was: [PATCH 1/9] device-mapper snapshot: load metadata on creation)
Message-ID: <20060420170535.GA24524@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060120211116.GB4724@agk.surrey.redhat.com> <87odz3f5m0.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87odz3f5m0.fsf@blackdown.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 01:19:51PM +0200, Juergen Kreileder wrote:
> I'm using devmapper 1.02.03 and lvm2 2.02.02 with 2.6.16.2,
> nevertheless my logical volumes locked up three time when removing
> snapshots so far.  Twice I got BUG at drivers/md/kcopyd.c:146, the
> third time logging stopped at the first lvremove.
 
> 2.6.15 and earlier kernels in combination with older tools worked fine
> over the last year.
 
I found several bugs in the snapshot code when I reviewed it,
including (thankfully hard-to-trigger) silent data corruption.

Patches went into 2.6.17-rc1.  [There's one unfinished patch
outstanding for a theoretical race that I've only been able to
reproduce under artificial conditions.]

> kernel BUG at drivers/md/kcopyd.c:146!

Probably needs this patch (12th March):

  dm snapshot: fix kcopyd destructor

Alasdair
-- 
agk@redhat.com
