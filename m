Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264615AbTE1Ihf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264616AbTE1Ihe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:37:34 -0400
Received: from gw.enyo.de ([212.9.189.178]:16145 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264615AbTE1Ihd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:37:33 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.69] ext3 error: rec_len %% 4 != 0
References: <8765nva43w.fsf@deneb.enyo.de>
	<20030528012512.5d631827.akpm@digeo.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
 linux-kernel@vger.kernel.org
Date: Wed, 28 May 2003 10:50:44 +0200
In-Reply-To: <20030528012512.5d631827.akpm@digeo.com> (Andrew Morton's
 message of "Wed, 28 May 2003 01:25:12 -0700")
Message-ID: <87ptm38nff.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Are you using htree?  Run
>
> 	dumpe2fs -h /dev/hda1 | grep features
>
> and if it says "dir_index" then try turning it off:
>
> 	tune2fs -O ^dir_index /dev/hda1
>
> and reboot.

No dir_index here, sorry.

> If it is not an htree problem (and htree seems pretty stable now)
> then possibly the IO system has lost some data.  If possible, try
> using a normal old disk (no RAID).

Sorry, that's not possible, the data does not fit onto a single
disk. 8-(

> Falling back to ext2 for a while would be interesting.

Okay, will fallback to ext2 next time a reboot is required.  (I guess
removing the has_journal feature using tune2fs is the easiest way to
do this, after a clean unmount, of course.)
