Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265138AbUENKAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265138AbUENKAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 06:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265130AbUENKAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 06:00:37 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:57257 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265138AbUENKAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 06:00:36 -0400
Date: Fri, 14 May 2004 12:00:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040514100017.GA23863@wohnheim.fh-wedel.de>
References: <20040513134847.GA2024@dreamland.darkstar.lan> <20040513145640.GA3430@dreamland.darkstar.lan> <20040513151549.GB31123@wohnheim.fh-wedel.de> <1084488980.1935.119.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1084488980.1935.119.camel@gaston>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 08:56:21 +1000, Benjamin Herrenschmidt wrote:
> > 
> > I'm not sure what the point behind the radeon_write_mode() is at all.
> > The best solution could be to just merge radeon_write_mode() and
> > radeonfb_set_par() into a single function and do the tons of OUTREG()
> > directly.  In that case, don't bother to fix any typos
> 
> No, they should stay separate functions. I may use write_mode in a
> different way in the future (like restoring previous mode on module
> unload for example) and I'm very much against merging 2 already too big
> function into one huge horror.

Not sure if the combined function would really be bigger than either
one alone.  Basically, set_par writes to a temp struct and write_mode
writes from the temp struct to hardware.  Sounds like quite a bit of
redundant code could be removed.

With more users for write_mode the seperate function makes sense
again, so you should keep it.  Just the second argument isn't valid
imo.

Jörn

-- 
Correctness comes second.
Features come third.
Performance comes last.
Maintainability is needed for all of them.
