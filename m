Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWC2Ekl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWC2Ekl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWC2Ekl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:40:41 -0500
Received: from asteria.debian.or.at ([86.59.21.34]:39371 "EHLO
	asteria.debian.or.at") by vger.kernel.org with ESMTP
	id S1750814AbWC2Ekk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:40:40 -0500
Date: Wed, 29 Mar 2006 06:40:39 +0200
From: Peter Palfrader <peter@palfrader.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16: Oops - null ptr in blk_recount_segments?
Message-ID: <20060329044039.GT25288@asteria.noreply.org>
Mail-Followup-To: Peter Palfrader <peter@palfrader.org>,
	linux-kernel@vger.kernel.org
References: <20060327022814.GV25288@asteria.noreply.org> <20060327043601.GE27189130@melbourne.sgi.com> <20060327045823.GW25288@asteria.noreply.org> <20060327061021.GT1173973@melbourne.sgi.com> <Pine.LNX.4.61.0603281621210.27529@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.61.0603281621210.27529@yvahk01.tjqt.qr>
X-PGP: 1024D/94C09C7F 5B00 C96D 5D54 AEE1 206B  AF84 DE7A AF6E 94C0 9C7F
X-Request-PGP: http://www.palfrader.org/keys/94C09C7F.asc
X-Accept-Language: de, en
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt schrieb am Dienstag, dem 28. März 2006:

> >These diffs:
> >
> >2006-01-18
> >[XFS] Fix a race in xfs_submit_ioend() where we can ...
> >2006-01-11
> >[XFS] fix writeback control handling fix a reversed ...
> >[XFS] cluster rewrites We can cluster mapped pages ...
> >[...]
> 
> I bet on the 3rd...

Just reverting #3[0] on 2.6.16 doesn't fix it either.

Peter, back on 2.6.14.2 for now.

0. one hunk didn't unapply cleanly, and the change was not obvious.  I
   opted for making the beginning of xfs_probe_cluster() look like:
|       /* First sum forwards in this page */
|       do {
|               if (!buffer_uptodate(bh) || (mapped != buffer_mapped(bh)))
|                       return total;
|               total += bh->b_size;
|       } while ((bh = bh->b_this_page) != head);
