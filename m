Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293362AbSBQUMG>; Sun, 17 Feb 2002 15:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293363AbSBQUL4>; Sun, 17 Feb 2002 15:11:56 -0500
Received: from dsl-213-023-043-245.arcor-ip.net ([213.23.43.245]:27269 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293362AbSBQULj>;
	Sun, 17 Feb 2002 15:11:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>, mingo@redhat.com,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>
Subject: Re: [RFC] Page table sharing
Date: Sun, 17 Feb 2002 21:16:09 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0202162219230.8326-100000@home.transmeta.com> <E16cX9a-0000D9-00@starship.berlin>
In-Reply-To: <E16cX9a-0000D9-00@starship.berlin>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, Rik van Riel <riel@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, manfred@colorfullife.com,
        wli@holomorphy.com, dmccr@us.ibm.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cXjG-0000Dj-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the patch as currently posted.  I've been hacking on it to implement 
the locking described in the previous mail, but really I think it's better to 
go with the simple, incorrect and lockless version for group pondering.

    http://people.nl.linux.org/~phillips/patches/ptab-2.4.17
    (almost the same as posted to lkml/linus yesterday)

In the posted patch, tracing is configed off, see:

#if 0
#  define ptab(cmd) cmd
#else
#  define ptab(cmd) nil
#endif

in mm.h.  Anybody who actually wants to hack on this will probably want to 
turn it on.  Sharing is also still restricted to id 9999, even though I find
I'm able to boot and run pretty well with system-wide sharing.  It's not fully
correct though, because there are lockups happening in some benchmarks 
(unixbench and some crazy things invented by Andrew Morton) and UML fails to
start properly.  UML does work properly when sharing is restricted to just
one ID, i.e., something deep in the system doesn't like sharing page tables 
at this point.

-- 
Daniel
