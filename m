Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVBCHE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVBCHE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 02:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVBCHE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 02:04:27 -0500
Received: from waste.org ([216.27.176.166]:6021 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262353AbVBCHEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 02:04:22 -0500
Date: Wed, 2 Feb 2005 23:04:15 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: e1000, sshd, and the infamous "Corrupted MAC on input"
Message-ID: <20050203070415.GC17460@waste.org>
References: <42019E0E.1020205@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42019E0E.1020205@stinkfoot.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 10:44:14PM -0500, Ethan Weinstein wrote:
> Hey all,
> 
> I've been having quite a time with the e1000 driver running at gigabit 
> speeds.  Running it at 100Fdx has never been a problem, which I've done 
> done for a long time. Last week I picked up a gigabit switch, and that's 
> when the trouble began.  I find that transferring large amounts of data 
> using scp invariably ends up with sshd spitting out "Disconnecting: 
> Corrupted MAC on input."  After deciding I must have purchased a bum 
> switch, I grabbed another model.. only to get the same error.
> Finally, I used a crossover cable between the two boxes, which resulted 
> in the same error from sshd again.

Well ssh isn't an especially good test as it's hard to debug.

Try transferring large compressed files via netcat and comparing the
results. eg:

host1# nc -l -p 2000 > foo.bz2

host2# nc host1 2000 < foo.bz2

If the md5sums differ, follow up with a cmp -bl to see what changed.

Then we can look at the failure patterns and determine if there's some
data or alignment dependence.

-- 
Mathematics is the supreme nostalgia of our time.
