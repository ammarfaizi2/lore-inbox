Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbTDVECb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 00:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbTDVECb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 00:02:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45503 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262905AbTDVECa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 00:02:30 -0400
Date: Mon, 21 Apr 2003 21:14:33 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 67-mjb2 vs 68-mjb1 (sdet degredation)
Message-ID: <149880000.1050984872@[10.10.2.4]>
In-Reply-To: <20030421205231.4392aaa7.akpm@digeo.com>
References: <1425480000.1050959528@flay>
 <20030421144631.4987db46.akpm@digeo.com><147950000.1050981750@[10.10.2.4]>
 <20030421205231.4392aaa7.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Here's a backout patch.  Does it fix it up?
>> 
>> Yeah, that fixes it. Ho hum ... I wonder if we can find something that
>> works well for both cases? I guess the options would be:
>> 
>> 1. Some way to make the rwlock mechanism itself faster.
>> 2. Try to fix the contention itself somehow for this instance.
> 
> You're using PIII's, which don't mind the additional buslocked operation. 
> P4's hate it.  We'd need to retest on big P4 and other architectures to
> decide.

OK, I can try do get someone to test on big x440s (P4 Xeon).
 
> I suspect the spinlock is better that the rwlock overall - having multiple
> CPUs looking up things in the same address_space is relatively uncommon. 
> Having one CPU looking things up in one address space is very common, and
> that's the thing which the s/rwlock/spinlock/ speeds up.

Yeah, wasn't really complaining - I think the spinlock is the right thing
to do ... I just wanted to nail down what caused it, and be sure it was
deliberate. Looks like it is, so that all seems OK. Thanks for the help ;-)

M.

