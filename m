Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270774AbTHFRcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270765AbTHFRcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:32:23 -0400
Received: from angband.namesys.com ([212.16.7.85]:30126 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S270763AbTHFRbQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:31:16 -0400
Date: Wed, 6 Aug 2003 21:31:14 +0400
From: Oleg Drokin <green@namesys.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] reiserfs: fix locking in reiserfs_remount
Message-ID: <20030806173114.GB15024@namesys.com>
References: <20030806093858.GF14457@namesys.com> <20030806172813.GB21290@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806172813.GB21290@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Aug 06, 2003 at 10:28:13AM -0700, Mike Fedyk wrote:
> >     Since reiserfs_remount can be called without BKL held, we better take BKL in there.
> >     Please apply the below patch. It is against 2.6.0-test2
> is the BKL in reiserfs_write_unlock()?

Yes.

> Do we need to be adding more BKL usage, instead of the same or less at this
> point?

Reiserfs needs BKL for it's journal operations. This is not "more",
for some time BKL was taken in the VFS, then whoever removed that,
forgot to propagate BKL down to actual fs methods that need the BKL.

Bye,
    Oleg
