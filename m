Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261856AbSJIRbZ>; Wed, 9 Oct 2002 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSJIRbZ>; Wed, 9 Oct 2002 13:31:25 -0400
Received: from ns0.cobite.com ([208.222.80.10]:14091 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S261856AbSJIRbW>;
	Wed, 9 Oct 2002 13:31:22 -0400
Date: Wed, 9 Oct 2002 13:36:57 -0400 (EDT)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] silence an unnescessary raid5 debugging message
Message-ID: <Pine.LNX.4.44.0210091330300.29237-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>LVM manages to trigger the "raid5: switching cache buffer size" printk 
>quiet voluminously when using a snapshot device.  The following patch 
>disables it by placing it under the debugging PRINTK macro.

Ben (and Ingo),

I happen to hit this message thousands of times per second sometimes under
normal operation in certain loads (raw devices for oracle and fs on LVM on
raid5).  I understand that it's annoying, I actually think it shouldn't be
removed, because it's telling the operator importantn information.

As I understand it, the message is indicating a really bad performance 
problem (i.e a complete flush of the stripe cache), and that anyone 
encountering it on a very frequent (i.e. annoying) basis should consider 
changing their setup.

Encountering this message has forced us to plan to split the single raid5 
we have into two, in order to satisfy the different request sizes of the 
raw-device vs. the ext3 fs.

David

P.S.  Is there any hope of fixing this issue so that the stripe cache can 
handle different sized requests?  Possibly is this a bug in LVM?

-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

