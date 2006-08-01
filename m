Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbWHAJZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWHAJZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWHAJZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:25:22 -0400
Received: from mail.gmx.de ([213.165.64.21]:16259 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932538AbWHAJZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:25:21 -0400
X-Authenticated: #428038
Date: Tue, 1 Aug 2006 11:25:14 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Avi Kivity <avi@argo.co.il>
Cc: Theodore Tso <tytso@mit.edu>, David Lang <dlang@digitalinsight.com>,
       David Masover <ninja@slaphack.com>, tdwebste2@yahoo.com,
       Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"expressed by kernelnewbies.org regarding reiser4 inclusion]
Message-ID: <20060801092514.GB2974@merlin.emma.line.org>
Mail-Followup-To: Avi Kivity <avi@argo.co.il>, Theodore Tso <tytso@mit.edu>,
	David Lang <dlang@digitalinsight.com>,
	David Masover <ninja@slaphack.com>, tdwebste2@yahoo.com,
	Nate Diller <nate.diller@gmail.com>,
	Adrian Ulrich <reiser4@blinkenlights.ch>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
	reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <20060801064837.GB1987@thunk.org> <44CF01C1.9070802@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CF01C1.9070802@argo.co.il>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2006, Avi Kivity wrote:

> There's no reason to repack *all* of the data.  Many workloads write and 
> delete whole files, so file data should be contiguous.  The repacker 
> would only need to move metadata and small files.

Move small files? What for?

Even if it is "only" moving metadata, it is not different from what ext3
or xfs are doing today (rewriting metadata from the intent log or block
journal to the final location).

The UFS+softupdates from the BSD world looks pretty good at avoiding
unnecessary writes (at the expense of a long-running but nice background
fsck after a crash, which is however easy on the I/O as of recent FreeBSD
versions).  Which was their main point against logging/journaling BTW,
but they are porting XFS as well to save those that need instant
complete recovery.

-- 
Matthias Andree
