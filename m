Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSIAWGs>; Sun, 1 Sep 2002 18:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSIAWGr>; Sun, 1 Sep 2002 18:06:47 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:60936
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318130AbSIAWGr>; Sun, 1 Sep 2002 18:06:47 -0400
Subject: Re: question on spinlocks
From: Robert Love <rml@tech9.net>
To: Oliver Neukum <oliver@neukum.name>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200209020002.41381.oliver@neukum.name>
References: <Pine.LNX.4.44.0209011553140.3234-100000@hawkeye.luckynet.adm> 
	<200209020002.41381.oliver@neukum.name>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 18:11:12 -0400
Message-Id: <1030918273.12110.3126.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-01 at 18:02, Oliver Neukum wrote:
> 
> > > No; spin_lock_irqsave/spin_unlock_irqrestore and spin_lock/spin_unlock
> > > have to be used in matching pairs.
> >
> > If it was his least problem! He'll run straight into a "schedule w/IRQs
> > disabled" bug.
> 
> OK, how do I drop an irqsave spinlock if I don't have flags?

See my previous message.

Do not do what you are trying to do.  Dropping a lock and calling
schedule is fine.  Ditto with the interrupt part.

But note:

	- interrupts will be reenabled when you reschedule and still
	  enabled when your task is finally running again.

	- Since interrupts are going to magically restore, if you are
	  worried about the state of interrupts previous to your
	  function... you have a problem.

OK?

	Robert Love

