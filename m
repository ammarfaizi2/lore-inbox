Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262783AbVA1Vxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbVA1Vxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVA1Vxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:53:37 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:46563 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262783AbVA1Vxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:53:36 -0500
Subject: Re: [2.6.11-rc2] kernel BUG at fs/reiserfs/prints.c:362
From: Lee Revell <rlrevell@joe-job.com>
To: Vladimir Saveliev <vs@namesys.com>
Cc: Jan Kara <jack@suse.cz>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1106835321.6191.130.camel@tribesman>
References: <200501271024.13778.rathamahata@ehouse.ru>
	 <1106821035.3270.30.camel@tribesman>
	 <20050127112647.GA20806@atrey.karlin.mff.cuni.cz>
	 <1106835321.6191.130.camel@tribesman>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 16:53:34 -0500
Message-Id: <1106949214.3705.37.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-27 at 17:15 +0300, Vladimir Saveliev wrote:
> Earlier reiserfs used to lock_kernel on entering and unlock on exit. The
> reason is that reiserfs has no fine grain locking protecting access to
> its data structures.
> Since that time there could be introduced some minor improvements,
> though.

No, reiser3 still does not have proper locking.  It uses the BKL for
everything.  This will not be fixed as reiser3 is in maintenance mode.
According to Hans "the fix is reiser4".

This came up early in the voluntary preemption development process, we
found reiser3 to be unusable for low latency audio due to the excessive
BKL use disabling preemption all over the place.

It would be interesting to test reiser3 with the preemptible BKL
enabled.

Lee  

