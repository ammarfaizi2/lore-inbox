Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUIKRXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUIKRXr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUIKRXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:23:47 -0400
Received: from the-village.bc.nu ([81.2.110.252]:46003 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268228AbUIKRXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:23:38 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>,
       Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091109463694ffd3@mail.gmail.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.58.0409110600120.26651@skynet>
	 <1094913222.21157.61.camel@localhost.localdomain>
	 <9e47339104091109463694ffd3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094919681.21157.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 17:21:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 17:46, Jon Smirl wrote:
> User 1's game queues up 20ms of 3D drawing commands.
> Process swap to user 2.  ->quiesce() is going to take 20ms. 
> User 2's timeslice expires and we go back to user 1.
> User 1 queues up another 20ms.
> 
> User 2's editor is never going to function.

If you implement it wrongly sure. If you implemented it right then
this occurs.

User 1 queues 20 ms of 3D commands
User 1 is pre-empted
User 2 wants the 2D engine
User 2 beings wait for 2D
User 2 sleeps
User 1 wakes
User 1 beings wait for 3D but discovers a claim is in progress
User 1 sleeps
User 2 wakes, runs commands

If you have DRI loaded then as you rightly say the obvious desired
outcome is that the fb engine either turns acceleration off or switches
to using the DRI layer. 

But this is a pretty obscure case, and one we can't even begin to
support yet anyway.



