Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWBVSNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWBVSNc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWBVSNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:13:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12440 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750917AbWBVSNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:13:31 -0500
Date: Wed, 22 Feb 2006 18:13:05 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Alasdair G Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
       Lars Marowsky-Bree <lmb@suse.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH 2/3] sysfs representation of stacked devices (dm) (rev.2)
Message-ID: <20060222181305.GD31641@agk.surrey.redhat.com>
Mail-Followup-To: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>,
	Alasdair G Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
	Lars Marowsky-Bree <lmb@suse.de>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org,
	device-mapper development <dm-devel@redhat.com>,
	Mike Anderson <andmike@us.ibm.com>
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D92.6010006@ce.jp.nec.com> <20060222163438.GC31641@agk.surrey.redhat.com> <43FC9BD4.1010901@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC9BD4.1010901@ce.jp.nec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 12:13:56PM -0500, Jun'ichi Nomura wrote:
> Alasdair G Kergon wrote:
> > This patch needs splitting up so that independent changes can be
> > considered separately.
> > c.f. The proposal from Mike Anderson (repeated below) which I prefer
> > because it makes it clear that a table always belongs to exactly one md.
 
> I like his proposed patch.
> The interface is useful for my purpose too and moving table
> creation inside _hash_lock means I don't need dm_get() neither.

The global _hash_lock should not be held (thereby locking out most dm ioctl 
operations on any device) while the slow populate_table() runs.

I'm trying out a variant of the patch that drops and reacquires that lock.
 
Alasdair
-- 
agk@redhat.com
