Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTEOO2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTEOO2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:28:13 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:47514 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264052AbTEOO2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:28:13 -0400
Message-Id: <200305151439.h4FEdQGi012649@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
In-reply-to: Your message of "Wed, 14 May 2003 21:30:14 PDT."
             <20030514.213014.91331736.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 15 May 2003 10:39:26 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030514.213014.91331736.davem@redhat.com>,"David S. Miller" writes
:
>I don't understand why a fixed number of ATM devs is
>required in order to keep all of the device list and locking
>stuff in one place.

some other places in the code want to iterate the list of atm devices:
one ioctl needs to count the list and then return the items, connect
can handle an open on 'any interface' so it needs to iterate the list.
there are a couple ways around this of course.  the simplest (to me)
would be to simply limit the number of atm interfaces to 16 or so.
walking the atm adapters would just meaning calling atm_dev_lookup()
in a loop.  other options would be an iterator mechnaism, or a function
to just return the current list of adapters (by adapter number of course
forcing you to do an atm_dev_lookup to get a reference).  any other
ideas or preferences?
