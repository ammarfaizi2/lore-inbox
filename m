Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSGaLlj>; Wed, 31 Jul 2002 07:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSGaLlj>; Wed, 31 Jul 2002 07:41:39 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:37106 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316491AbSGaLlj>; Wed, 31 Jul 2002 07:41:39 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020731121054.A26396@ucw.cz> 
References: <20020731121054.A26396@ucw.cz>  <20020730225736.K7677@flint.arm.linux.org.uk> <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730221722.A22761@ucw.cz> <20020730225736.K7677@flint.arm.linux.org.uk> <9658.1028109354@redhat.com> <20020731115818.A26329@ucw.cz> <10657.1028110041@redhat.com> 
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net, torvalds@transmeta.com
Subject: sleep_on() DIE DIE DIE (was Re: [patch] Fix suspend of the kseriod thread)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 31 Jul 2002 12:44:52 +0100
Message-ID: <2798.1028115892@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vojtech@suse.cz said:
> On Wed, Jul 31, 2002 at 11:07:21AM +0100, David Woodhouse wrote:
> > vojtech@suse.cz said:
> > >  Ok. Is the use in drivers/input/serio.c buggy? 
> > 
> > If it matters that the thread can miss wakeup events and sleep
> > indefinitely while there's a 'SERIO_RESCAN' event pending, then
> > yes it looks buggy.
	<...>
> Thanks for the explanation. Yes, this could happen.

Quod Erat Demonstrandum.

Even people who can be assumed to have a clue can make the mistake of using 
sleep_on() in spite of the fact that it's almost impossible to use 
correctly.

It can be removed from 2.5 without much pain -- half the drivers are broken
anyway due to the removal of cli(). I'm running a kernel with sleep_on()
removed quite happily.

At Stephen's request, I'll wait a couple of days for ext3 to remove all use
of sleep_on() before submitting the patch. NFS wants fixing too, but other 
than that the breakage seems remarkably slight.

--
dwmw2


