Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTL2RZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTL2RZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:25:32 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:24218 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S263771AbTL2RZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:25:23 -0500
Date: Mon, 29 Dec 2003 17:25:01 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: chmod of active swap file blocks
In-Reply-To: <20031229013040.0a953dd0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.56.0312291719160.16956@fogarty.jakma.org>
References: <Pine.LNX.4.56.0312290434360.2270@fogarty.jakma.org>
 <20031229013040.0a953dd0.akpm@osdl.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Andrew Morton wrote:

> The kernel holds the swapfile's i_sem while it is in use.  This is
> to prevent the filesystem destruction which would result if some
> silly person were to truncate a swapfile while it was in active
> use.

Ah, ok. /sort/ of makes sense..

> It is not a particularly important safety feature ("don't do that")
> and it can be taken out if it is causing serious side-effects.

though i'd err more on the side of "dont do that" :)

> Is chmod of an in-use swapfile an important thing to be able to do?

Had a box under memory pressure and had to add a swapfile to relieve
said pressure. Noticed afterwards that it had been created under
umask 0022 - not good, and the chmod to remove read rights for all 
blocked. Thankfully, it was my desktop, not a multiple user server :)

I dont know, I think I'd prefer ability to change attributes of the
swap file while its still swapped - there are many other, and far
more catastrophic, ways for root to kill the box, does it make sense
to guard against this one if it interferes with normal operations?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
"...and scantily clad females, of course.  Who cares if it's below zero
outside"
(By Linus Torvalds)
