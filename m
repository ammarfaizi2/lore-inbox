Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268775AbUILSdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268775AbUILSdt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268776AbUILSdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:33:49 -0400
Received: from the-village.bc.nu ([81.2.110.252]:25525 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268775AbUILSdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:33:46 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hamie <hamish@travellingkiwi.com>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <414434A0.9000401@travellingkiwi.com>
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
	 <1094919681.21157.119.camel@localhost.localdomain>
	 <41434DA0.3050408@travellingkiwi.com>
	 <1094944787.21702.3.camel@localhost.localdomain>
	 <414434A0.9000401@travellingkiwi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095010290.11736.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 12 Sep 2004 18:31:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-12 at 12:36, Hamie wrote:
> But this relies on drivers co-operating with each other. 

Only minimally, and providing the co-operation is easy the rest comes
out fine. We don't often get ide-disk and ide-cd people arguing over
whose fault something is

> Yeah. Would fglrx  be more stable if you used the external AGP rather 
> than fglrx's built in AGP driver?

Who knows, ATI have the source, ask them 8)

> >My code ends up looking like
> >
> >	lock
> >	if(someone_else_used_it)
> >		restore_my_state()
> >	blah 
> >	unlock
>
> Ah... Now I understand what you've been talking about as well... The 
> only caveat is whether you can always restore your own state from the 
> state the other person put it into. Do any cards exist where you could 
> perhaps still lock the card up because you didn't know the current state 
> of the card?

There are lots of cards where you might need more than the basic
example. You need to know your own state clearly, you often can't
retrieve that from the card. You may also need to know the previous user
has left it in a sane state. That might lead you to say

	lock
		oldowner->release()
	blah
	unlock (&release_func)

so that the previous caller is told it is losing the lock and can
for example wait for its commands to complete.


