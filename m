Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267026AbTGTMkq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 08:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267058AbTGTMkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 08:40:46 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:60679 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S267026AbTGTMkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 08:40:45 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@muc.de>
Cc: linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels? 
In-reply-to: Your message of "Fri, 18 Jul 2003 22:43:57 +0200."
             <m3smp3y38y.fsf@averell.firstfloor.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Jul 2003 22:55:18 +1000
Message-ID: <1681.1058705718@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 22:43:57 +0200, 
>I actually started on porting the KDB backtracer recently to get
>reliable frame pointer based backtraces, but it turns out the code
>for that is so complicated and ugly that the chances of ever merging
>it would be very slim.

Mainly because the kernel is full of special cases and i386 provides no
unwind data to help decode those special cases, so all the special case
code ends up in kdba_bt.c.  Compare the complexity of i386 kdba_bt.c
with ia64 kdba_bt.c, the latter is significantly simpler because ia64
mandates unwind data.  Without unwind data, kdb has to use lots of
awkward heuristics to even guess at an accurate backtrace.  Don't blame
kdb for the lack of i386 unwind data.

