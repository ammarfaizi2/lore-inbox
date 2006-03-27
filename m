Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWC0EgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWC0EgX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 23:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWC0EgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 23:36:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33978 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932170AbWC0EgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 23:36:22 -0500
Date: Mon, 27 Mar 2006 15:36:01 +1100
From: David Chinner <dgc@sgi.com>
To: Peter Palfrader <peter@palfrader.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16: Oops - null ptr in blk_recount_segments?
Message-ID: <20060327043601.GE27189130@melbourne.sgi.com>
References: <20060327022814.GV25288@asteria.noreply.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327022814.GV25288@asteria.noreply.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 04:28:14AM +0200, Peter Palfrader wrote:
> Hey,
> 
> I've seen a few of these since upgrading to 2.6.16 on my x86_64 system:

What did you upgrade from?

....

> [14513.189101] Call Trace: <ffffffff80288e8d>{blk_recount_segments+125}
> [14513.189113]        <ffffffff8045ab19>{schedule_timeout+153} <ffffffff8017df90>{__bio_clone+128}
> [14513.189134]        <ffffffff8017dfed>{bio_clone+61} <ffffffff80144a70>{autoremove_wake_function+0}
> [14513.189143]        <ffffffff882576c1>{:dm_crypt:crypt_alloc_buffer+65}
> [14513.189157]        <ffffffff8825813e>{:dm_crypt:crypt_map+174} <ffffffff8823b463>{:dm_mod:__map_bio+83}
> [14513.189190]        <ffffffff8823b6a8>{:dm_mod:__clone_and_map+168} <ffffffff8823b8de>{:dm_mod:__split_bio+174}
> [14513.189223]        <ffffffff8823b9dc>{:dm_mod:dm_request+204} <ffffffff8028b532>{generic_make_request+258}
> [14513.189243]        <ffffffff8028b628>{submit_bio+216} <ffffffff8017e20f>{__bio_add_page+463}
> [14513.189256]        <ffffffff8026bd3e>{xfs_submit_ioend_bio+30} <ffffffff8026bec0>{xfs_submit_ioend+144}
> [14513.189269]        <ffffffff8026cd03>{xfs_page_state_convert+1379} <ffffffff8026d2e0>{linvfs_writepage+176}

This area of XFS changed in 2.6.16; it might be doing something wrong
with bios that is blowing up later. Then again, it might be something in dm
that is wrong. Does this happen on non-dmcrypt XFS filesystems you have?

I understand that the recognised way to find introduced a reproducable problem
like this is to do a git bisect to find the mod that introduced the problem.
Is it possible for you to do this?

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
