Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbRBNJwe>; Wed, 14 Feb 2001 04:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBNJwY>; Wed, 14 Feb 2001 04:52:24 -0500
Received: from CPE-61-9-150-70.vic.bigpond.net.au ([61.9.150.70]:47621 "EHLO
	halfway") by vger.kernel.org with ESMTP id <S129161AbRBNJwL>;
	Wed, 14 Feb 2001 04:52:11 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: court@oz.agile.tv
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: On "Unreliable Locking Guide" bug ? 
In-Reply-To: Your message of "Wed, 14 Feb 2001 10:00:39 +1000."
             <3A89CAA7.5090400@oz.agile.tv> 
Date: Wed, 14 Feb 2001 15:35:23 +1100
Message-Id: <E14Stf2-0001th-00@halfway>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3A89CAA7.5090400@oz.agile.tv> you write:
> Hi Paul,
> 
> I am reviewing your "Unreliable Locking Guide" from linux 2.4 and just 
> wonder about the
> section on "Avoiding Locks: Read and Write".  The two lines of code
> 
> new->next = i-> next;
> i->next = new;

Hi John,

	Yes, there is of course a lock against other list
manipulations.  I've attached a patch to make this clear..

Thanks!
Rusty.

--- linux-2.4.0-official/Documentation/DocBook/kernel-locking.tmpl.~1~	Sat Dec 30 09:07:19 2000
+++ linux-2.4.0-official/Documentation/DocBook/kernel-locking.tmpl	Wed Feb 14 15:33:36 2001
@@ -720,7 +720,8 @@
       halves without a lock.  Depending on their exact timing, they
       would either see the new element in the list with a valid 
       <structfield>next</structfield> pointer, or it would not be in the 
-      list yet.
+      list yet.  A lock is still required against other CPUs inserting
+      or deleting from the list, of course.
     </para>
 
     <para>
--
Premature optmztion is rt of all evl. --DK
