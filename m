Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274248AbRJEWYM>; Fri, 5 Oct 2001 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274249AbRJEWYD>; Fri, 5 Oct 2001 18:24:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17419 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274248AbRJEWXn>; Fri, 5 Oct 2001 18:23:43 -0400
Subject: Re: Context switch times
To: george@mvista.com (george anzinger)
Date: Fri, 5 Oct 2001 23:29:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), bcrl@redhat.com (Benjamin LaHaise),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3BBDF290.E3988F49@mvista.com> from "george anzinger" at Oct 05, 2001 10:49:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pdSv-0007qX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me see if I have this right.  Task priority goes to max on any (?)
> sleep regardless of how long.  And to min if it doesn't sleep for some
> period of time.  Where does the time slice counter come into this, if at
> all?  
> 
> For what its worth I am currently updating the MontaVista scheduler so,
> I am open to ideas.

The time slice counter is the limit on the amount of time you can execute,
the priority determines who runs first.

So if you used your cpu quota you will get run reluctantly. If you slept
you will get run early and as you use time slice count you will drop
priority bands, but without pre-emption until you cross a band and there
is another task with higher priority.

This damps down task thrashing a bit, and for the cpu hogs it gets the
desired behaviour - which is that the all run their full quantum in the
background one after another instead of thrashing back and forth
