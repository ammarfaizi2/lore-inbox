Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312326AbSCYHEM>; Mon, 25 Mar 2002 02:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312322AbSCYHEC>; Mon, 25 Mar 2002 02:04:02 -0500
Received: from [202.135.142.194] ([202.135.142.194]:63758 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312325AbSCYHDw>; Mon, 25 Mar 2002 02:03:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: bit ops on unsigned long? 
Cc: linux-kernel@vger.kernel.org
In-Reply-To: Your message of "Sun, 24 Mar 2002 23:21:16 PDT."
             <200203250621.g2P6LG023329@vindaloo.ras.ucalgary.ca> 
Date: Mon, 25 Mar 2002 18:07:07 +1100
Message-Id: <E16pOZP-00043F-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200203250621.g2P6LG023329@vindaloo.ras.ucalgary.ca> you write:
> > These changed are required because otherwise you try to do set_bit on
> > something not aligned as a long on all archs.
> 
> But of course. I'm not denying that. Naturally the type should be
> changed. I thought that was obvious so I didn't bother agreeing. But
> in fact, it already *is* aligned on a long boundary. Better, in
> fact. It's aligned on a 16 byte boundary. Even though the type was
> __u32.

I'm confused:

@@ -212,7 +212,7 @@
 struct minor_list
 {
     int major;
-    __u32 bits[8];
+    unsigned long bits[256 / BITS_PER_LONG];
     struct minor_list *next;
 };

How, exactly, did "bits" end up on a 16-bute boundary before this
patch?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
