Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbUKEWvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUKEWvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUKEWvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:51:55 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:14997 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261240AbUKEWvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:51:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: breakage: flex mmap patch for x86-64
Date: Fri, 5 Nov 2004 23:51:11 +0100
User-Agent: KMail/1.6.2
Cc: ak@suse.de, Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       Ricky Beam <jfbeam@bluetronic.net>
References: <Pine.GSO.4.33.0411051716230.9358-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0411051716230.9358-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411052351.11940.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 of November 2004 23:24, Ricky Beam wrote:
> ChangeSet Key: 4188122b4-5vHFkvfD5Pc0Egjyaz8w
> 
> ======== ChangeSet 1.2424.7.12 ========
> D 1.2424.7.12 04/11/02 15:03:07-08:00 ak@suse.de[torvalds] 53848 53847 3/0/1
> P ChangeSet
> C [PATCH] x86_64: flex mmap patch for x86-64
> C
> C From: Arjan van de Ven <arjanv@redhat.com>
> C
> C Do flex mmap for x86-64.  mmaps will grow down in the address space now
> C instead of up.
> C
> C Patch has 2 parts; the generic strategy selection, and code to make a 
correct
> C TASK_SIZE .  the later may be fixed in your tree already in which case 
it's
> C redundant.
> C
> C Modified by AK to apply to 64bit processes too.
> C
> C Signed-off-by: Andrew Morton <akpm@osdl.org>
> C Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> ------------------------------------------------
> 
> This prevents 32bit apps from running on x86_64.  Backing out the Makefile
> and processor.h changes has everything working again.  Perhaps something
> needs to check for a 32bit environment?  I don't know if it's the change
> to TASK_SIZE or the "backwards" mmaps that's the real breakage.  And at this
> point, I don't have time to test.
> 
> (64bit apps work just fine.)

Confirmed, and apparently it is not sifficient to change the TASK_SIZE 
definition in include/asm-x86_64/processor.h to make the 32-bit userland 
work.  Hence, it seems that the "backwards" mmaps break things.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
