Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVGLUvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVGLUvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVGLUtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:49:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262394AbVGLUsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:48:06 -0400
Date: Tue, 12 Jul 2005 21:47:51 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc2-mm2 : oops in dm_mod
Message-ID: <20050712204751.GB12341@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Laurent Riffard <laurent.riffard@free.fr>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20050712021724.13b2297a.akpm@osdl.org> <42D41177.9020300@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D41177.9020300@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 08:52:39PM +0200, Laurent Riffard wrote:
> I just got this oops.
 
> EIP is at suspend_targets+0x8/0x42 [dm_mod]

I fear the empty patch the script gave me yesterday wasn't meant 
to be empty...  [Yes, I'm going to switch to quilt just as soon as 
I can make time to convert everything.]

I'm downloading -mm2 as I write this to check, but I can't
spot the part of the patch that updates dm-table.c to read:

void dm_table_presuspend_targets(struct dm_table *t)
{
        if (!t)
                return;

        return suspend_targets(t, 0);
}
                                                                                
void dm_table_postsuspend_targets(struct dm_table *t)
{
        if (!t)
                return;
                                                                                
        return suspend_targets(t, 1);
}

Alasdair

