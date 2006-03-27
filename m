Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWC0E6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWC0E6Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 23:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWC0E6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 23:58:25 -0500
Received: from asteria.debian.or.at ([86.59.21.34]:36005 "EHLO
	asteria.debian.or.at") by vger.kernel.org with ESMTP
	id S1751607AbWC0E6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 23:58:24 -0500
Date: Mon, 27 Mar 2006 06:58:23 +0200
From: Peter Palfrader <peter@palfrader.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16: Oops - null ptr in blk_recount_segments?
Message-ID: <20060327045823.GW25288@asteria.noreply.org>
Mail-Followup-To: Peter Palfrader <peter@palfrader.org>,
	linux-kernel@vger.kernel.org
References: <20060327022814.GV25288@asteria.noreply.org> <20060327043601.GE27189130@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060327043601.GE27189130@melbourne.sgi.com>
X-PGP: 1024D/94C09C7F 5B00 C96D 5D54 AEE1 206B  AF84 DE7A AF6E 94C0 9C7F
X-Request-PGP: http://www.palfrader.org/keys/94C09C7F.asc
X-Accept-Language: de, en
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2006, David Chinner wrote:

> > I've seen a few of these since upgrading to 2.6.16 on my x86_64 system:
> 
> What did you upgrade from?

2.6.14.2.


> > [14513.189101] Call Trace: <ffffffff80288e8d>{blk_recount_segments+125}
> > [14513.189113]        <ffffffff8045ab19>{schedule_timeout+153} <ffffffff8017df90>{__bio_clone+128}
> > [14513.189134]        <ffffffff8017dfed>{bio_clone+61} <ffffffff80144a70>{autoremove_wake_function+0}
> > [14513.189143]        <ffffffff882576c1>{:dm_crypt:crypt_alloc_buffer+65}
> > [14513.189157]        <ffffffff8825813e>{:dm_crypt:crypt_map+174} <ffffffff8823b463>{:dm_mod:__map_bio+83}
> > [14513.189190]        <ffffffff8823b6a8>{:dm_mod:__clone_and_map+168} <ffffffff8823b8de>{:dm_mod:__split_bio+174}
> > [14513.189223]        <ffffffff8823b9dc>{:dm_mod:dm_request+204} <ffffffff8028b532>{generic_make_request+258}
> > [14513.189243]        <ffffffff8028b628>{submit_bio+216} <ffffffff8017e20f>{__bio_add_page+463}
> > [14513.189256]        <ffffffff8026bd3e>{xfs_submit_ioend_bio+30} <ffffffff8026bec0>{xfs_submit_ioend+144}
> > [14513.189269]        <ffffffff8026cd03>{xfs_page_state_convert+1379} <ffffffff8026d2e0>{linvfs_writepage+176}
> 
> This area of XFS changed in 2.6.16; it might be doing something wrong
> with bios that is blowing up later. Then again, it might be something in dm
> that is wrong. Does this happen on non-dmcrypt XFS filesystems you have?

All the Oopses so far had dm_crypt in their backtrace, but then the
non-crypted XFSs don't see that much action.  Also, I recently added a
new XFS filesytem to the system.  Is there a way to tell which of them
causes the Oops?

> I understand that the recognised way to find introduced a reproducable problem
> like this is to do a git bisect to find the mod that introduced the problem.
> Is it possible for you to do this?

I can certainly try but it usually takes several hours or a at least a
few days to manifest here on my desktop.

-- 
 PGP signed and encrypted  |  .''`.  ** Debian GNU/Linux **
    messages preferred.    | : :' :      The  universal
                           | `. `'      Operating System
 http://www.palfrader.org/ |   `-    http://www.debian.org/
