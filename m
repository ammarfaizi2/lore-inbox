Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTFFKqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 06:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTFFKqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 06:46:40 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:62453 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261192AbTFFKqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 06:46:39 -0400
Message-Id: <200306061100.h56B08sG024506@ginger.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 02:36:18 PDT."
             <20030606.023618.13768006.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 06:58:20 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606.023618.13768006.davem@redhat.com>,"David S. Miller" writes:
>Are you sure nothing needs to walk the list in interrupt or softint
>context?  That's why you can't normally protect all of it using the
>RTNL semaphore, because walks occur in non-sleepable contexts.

oddly enough, i dont believe the list is iterated in interrupt
context.

>Read the comment above dev_base in drivers/net/Space.c to see what
>the intended locking model is.

yeah, i already read that.  it has a bit of a typo (rtln indeed).
it looks like rtnl_lock() is also used to protect dev_ioctl's
(thus my usage in atm_ioctl) and protect lookup's like __dev_get_by_name.
i didnt get rid of atm_dev_lock, i just dont use it unless writing
or if i couldnt safely use rtnl when a reader is iterating (like
atm_dev_hold() which could be called at interrupt--though no one does).
i thought this was the idea.
