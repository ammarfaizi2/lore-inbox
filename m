Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVCHQcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVCHQcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 11:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVCHQcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 11:32:52 -0500
Received: from bay101-f39.bay101.hotmail.com ([64.4.56.49]:15176 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261412AbVCHQcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 11:32:50 -0500
Message-ID: <BAY101-F396925B373DD3925D37BFEC1500@phx.gbl>
X-Originating-IP: [129.80.22.143]
X-Originating-Email: [peter_w_morreale@hotmail.com]
From: "Peter W. Morreale" <peter_w_morreale@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 08 Mar 2005 09:32:48 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Mar 2005 16:32:49.0361 (UTC) FILETIME=[77812410:01C523FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a driver I am reviewing I found the following locking constructs.
Notice how 'foo" is being called while we have suspended interrupts.

This seems wrong since we've mixed locking primitives.

Is it?

Thanks in advance.

-PWM

---------------------snip--------------------------------------
spin_lock_irqsave(global_lock, &flags);
....
foo()
{
    unsigned long lflags;

    spin_unlock(global_lock);
    ...
    {
        spin_lock_irqsave(global_lock, &lflags);
                .
                .
        spin_unlock_irqrestore(global_lock, &lflags);
    }

    spin_lock_irq(global_lock);
}

spin_unlock_irqrestore(global_lock, &flags);


