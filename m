Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbTEGJfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 05:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263047AbTEGJfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 05:35:23 -0400
Received: from zero.aec.at ([193.170.194.10]:21775 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263029AbTEGJfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 05:35:22 -0400
Date: Wed, 7 May 2003 11:47:52 +0200
From: Andi Kleen <ak@muc.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030507094752.GA4050@averell>
References: <20030506063055.GA15424@averell> <20030507092329.GA2389@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030507092329.GA2389@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc list trimmed]

On Wed, May 07, 2003 at 11:23:29AM +0200, Jörn Engel wrote:
> I've been a bit sceptical of the whole .altinstructions idea,
> self-modifying code opens a can of worms for anyone trying to do code
> analysis (coverage, verification,...). But with this followup, I
> personally pay money to get that stuff ripped out again.

Ok. How much do you pay ? ;@)

Seriously. To give some numbers. This is the maxi kernel (about 8MB .text,
everything compiled in that compiles in 2.5.69) which is far too big to even 
even boot.

 20 .exit.text    00005afa  c0ada3d0  c0ada3d0  009db3d0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE

About 20k from 8MB

On a realistic kernel that actually boots we are talking about 1-2KB,
probably even less. If you really wanted to combat bloat there are a lot 
other areas where you can avoid much more than 2KB with minimum effort.
Just go through include/linux/* and move a few unnecessary inlines away, that
will help much more. If you want to save real memory attack mem_map, like
I proposed earlier.

-Andi

P.S.: In case someone is interested: The hall of shame for the 2.5.69 SMP
maxi kernel (stuff that doesn't build) currently is:  Sound/Alsa (one driver 
doesn't compile), USB (3 drivers don't compile), MTD (lots of stuff doesn't 
compile).  Everything else is quite good.
