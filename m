Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVAMRAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVAMRAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVAMQmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:42:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:33252 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261230AbVAMQlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:41:12 -0500
Subject: Re: User space out of memory approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ilias Biris <xyz.biris@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4e1a70d10501111246391176b@mail.gmail.com>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
	 <4e1a70d1050111111614670f32@mail.gmail.com>
	 <4e1a70d10501111246391176b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105630523.4644.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-11 at 20:46, Ilias Biris wrote:
> well looking into Alan's email again I think I answered thinking on
> the wrong side :-) that the suggestion was to switch off OOM
> altogether and be done with all the discussion... tsk tsk tsk too
> defensive and hasty I guess :-)

Thats what mode 2 is all about. There are some problems with over-early
triggering of OOM that Andrea fixed that are still relevant (or stick
"never OOM if mode == 2" into your kernel)

> Did I get it right this time Alan? 

Basically yes - the real problem with the OOM situation is there is no
correct answer. People have spent years screwing around with the OOM
killer selection logic and while you can make it pick large tasks or old
tasks or growing tasks easily nobody has a good heuristic about what to
die because it depends on the users wishes. OOM requires AF_TELEPATHY
sockets and we don't have them.

For most users simply not allowing the mess to occur solves the problem
- not all but most.

