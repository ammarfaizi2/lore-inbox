Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVAPEiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVAPEiH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVAPEhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:37:39 -0500
Received: from one.firstfloor.org ([213.235.205.2]:52934 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262425AbVAPEhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:37:35 -0500
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Tridgell <tridge@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Ext3 nanosecond timestamps in big inodes
References: <200501142216.12726.agruen@suse.de>
From: Andi Kleen <ak@muc.de>
Date: Sun, 16 Jan 2005 05:37:34 +0100
In-Reply-To: <200501142216.12726.agruen@suse.de> (Andreas Gruenbacher's
 message of "Fri, 14 Jan 2005 22:16:12 +0100")
Message-ID: <m1acravvjl.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> writes:

> this is a spin-off of an old patch by Alex Tomas <alex@clusterfs.com>:
> Alex originally had nanosecond timestamps in his original patch; here is
> a rejuvenated version. Please tell me what you think. Alex also added a
> create timestamp in his original patch. Do we actually need that?
>
> Nanoseconds consume 30 bits in the 32-bit fields. The remaining two bits 
> currently are zeroed out implicitly. We could later use them remaining two 
> bits for years beyond 2038.

Looks good. Just two suggestions:

- Provide an mount option to turn it off because there may be
performance regressions in some workload because inodes will be
flushed more often.
[I actually considered doing this generally at the VFS level
when doing the s_time_gran patch, but it needed some more changes
that I didn't want to do at that time. Doing it in the FS as
interim solution would be fine too]

- Use the 2 bits for additionals years right now on 64bit
hosts. No need to keep the y2038 issue around longer than necessary.

-Andi
