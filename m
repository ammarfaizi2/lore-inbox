Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbUK3CC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUK3CC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUK3CBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:01:52 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:58779 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261825AbUK3B7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 20:59:06 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Robert Murray <rob@mur.org.uk>
Date: Tue, 30 Nov 2004 12:58:43 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16811.54227.681707.243145@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid1 oops in 2.6.9 (debian package 2.6.9-1-686-smp)
In-Reply-To: message from Robert Murray on Sunday November 28
References: <20041128142840.GA4119@mur.org.uk>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 28, rob@mur.org.uk wrote:
> Hi
> 
> The complete console log can be found at
> http://haylott.plus.com/~robbie/md-oops.txt

This looks like a known bug that is fixed in current 2.6.10
pre-releases. 
> 
> hde is a failed drive. In this log, hdg (the other drive in the raid1
> array) is not present. This oops also occurs when hdg is present. I
> don't know why it tries to use hde when it has been failed for some
> time now.

It tries to use hde because it sees no reason not to.
When a drive fails, md never writes to it again, so the record of it
being part of a raid1 array is still there.
If it is assembled with another drive that "knows" that hde has
failed, then it won't accept hde into the array.  But the hdg missing,
hde is the best bet it has, and it tries it anyway.

NeilBrown
