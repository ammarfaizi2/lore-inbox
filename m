Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292923AbSBVQL3>; Fri, 22 Feb 2002 11:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292924AbSBVQLV>; Fri, 22 Feb 2002 11:11:21 -0500
Received: from 216-42-72-168.ppp.netsville.net ([216.42.72.168]:61325 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S292923AbSBVQLH>; Fri, 22 Feb 2002 11:11:07 -0500
Date: Fri, 22 Feb 2002 11:10:31 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Message-ID: <1004510000.1014394231@tiny>
In-Reply-To: <200202221557.g1MFvp004149@localhost.localdomain>
In-Reply-To: <200202221557.g1MFvp004149@localhost.localdomain>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, February 22, 2002 10:57:51 AM -0500 James Bottomley <James.Bottomley@steeleye.com> wrote:

[ very interesting stuff ]

> Finally, I think the driver ordering problem can be solved easily as long as 
> an observation I have about your barrier is true.  It seems to me that the 
> barrier is only semi permeable, namely its purpose is to complete *after* a 
> particular set of commands do.  

This is my requirement for reiserfs, where I still want to wait on the 
commit block to check for io errors.  sct might have other plans.

> This means that it doesnt matter if later 
> commands move through the barrier, it only matters that earlier commands 
> cannot move past it?  If this is true, then we can fix the slot problem simply 
> by having a slot dedicated to barrier tags, so the processing engine goes over 
> it once per cycle.  However, if it finds the barrier slot full, it doesn't 
> issue the command until the *next* cycle, thus ensuring that all commands sent 
> down before the barrier (plus a few after) are accepted by the device queue 
> before we send the barrier with its ordered tag.

Interesting, certainly sounds good.

-chris

