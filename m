Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTBHBDg>; Fri, 7 Feb 2003 20:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBHBDg>; Fri, 7 Feb 2003 20:03:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44783 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id <S266940AbTBHBDg>;
	Fri, 7 Feb 2003 20:03:36 -0500
Date: Fri, 7 Feb 2003 17:13:16 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: jsun@mvista.com
Subject: [2.5 Question] Is TIF_USEDFPU cleared for a new process?
Message-ID: <20030207171316.B27605@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4, this flag is cleared in the common code, copy_flags(), 
when a new process is created.  Not so anymore in 2.5.  I wonder 
if it ever cleared.

I looked at the code (2.5.59) a couple of times and can't seem
to find any place it is cleared for a new process.

Assuming it is not cleared, I am interested in knowing what
would happen, especially in the following scenario:

1) the new process is switched on, runs without using any FPU

2) the new process is switched off.  Because the TIF_USEDFPU
   is set, it will execute 'fnsave' or 'fxsave'.

   a) if FPU is enabled at this moment, we will save bogus FPU
      contents back into new process's thread structure.
   b) if FPU is not enabled, we will go through the trap, restore
      FPU registers from the thread structure, and then save
      the same value back into the thread structure again.

Either a) or b) is bad.  Is this scenario real or just fictitious?

Please cc your reply to my email address.  Thanks.

Jun
