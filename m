Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVAWW4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVAWW4b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 17:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVAWW4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 17:56:31 -0500
Received: from levante.wiggy.net ([195.85.225.139]:49642 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261369AbVAWW43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 17:56:29 -0500
Date: Sun, 23 Jan 2005 23:56:28 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: negative diskspace usage
Message-ID: <20050123225628.GA27675@wiggy.net>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	linux-kernel@vger.kernel.org
References: <20050121141106.GG7147@wiggy.net> <20050122212328.GC11170@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050122212328.GC11170@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andries Brouwer wrote:
> I assume this was produced by statfs or statfs64 or so.

statfs64 indeed.

> Are you still able to examine the situation?

No, but I do have some more information. A e2fsck run on that filesystem
was just as interesting:

/dev/md4: clean, 16/132480 files, -15514/264960 blocks

Forcing an e2fsck revelated a few groups with incorrect block counts:

Free blocks count wrong for group #2 (34308, counted=32306).
Free blocks count wrong for group #6 (45805, counted=32306).
Free blocks count wrong for group #8 (14741, counted=2354).
Free blocks count wrong (280474, counted=252586).

After fixing those everything returned to normal. I did run dumpe2fs
on the filesystem, if that is interesting I can retrieve and post that.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
