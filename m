Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbUL1TVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUL1TVx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 14:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUL1TVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 14:21:53 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:17843 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261218AbUL1TVv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 14:21:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
Date: Tue, 28 Dec 2004 14:21:49 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, mingo@redhat.com
References: <1104249508.22366.101.camel@localhost.localdomain> <200412281350.44195.dtor_core@ameritech.net> <20041228105330.6da0f0ea.davem@davemloft.net>
In-Reply-To: <20041228105330.6da0f0ea.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412281421.49044.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 December 2004 01:53 pm, David S. Miller wrote:
> On Tue, 28 Dec 2004 13:50:40 -0500
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> 
> > Please look at the patch below (handful of arches only and against
> > some old tree, but you'll see what I wanted to do). What I meant
> > by changing the semantics is that reporting is delayed by 1 interrupt.
> 
> This looks exactly like what I was looking for.  I think I misunderstood
> your original description, which is why it is always best to communicate
> ideas using patches :)
> 
> My misunderstanding what that I thought that your flag would work
> like this:
> 
> 1) input interrupt occurs, flag is set
> 2) IRQ handling completes
> 3) some new IRQ arrives, and this is when we test
>    the flag for dumping sysrq regs
> 
> That, fortunately, is not what your patch is doing.

Well, it kind of does... I mean if register dump is somehow requested 
from outside of interrupt context then you'll get dump of the next hard
IRQ. The same goes for softirqs I guess.
  
-- 
Dmitry
