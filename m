Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318230AbSG3L07>; Tue, 30 Jul 2002 07:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSG3L06>; Tue, 30 Jul 2002 07:26:58 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:4580 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S318230AbSG3L05>; Tue, 30 Jul 2002 07:26:57 -0400
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Tue, 30 Jul 2002 07:30:03 -0400
References: <Pine.LNX.4.44.0207282324340.872-100000@home.transmeta.com>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20020730113004.5776D117D@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Sun, 28 Jul 2002, David S. Miller wrote:
>>
>> So when the user's reference is dropped, does that operation kill it
>> from the LRU or will the socket's remaining reference to that page
>> defer the LRU removal?
> 
> That is indeed the question. Right now it will defer, which looks like a
> bug. Or at least it is a bug without the interrupt-safe LRU manipulations.
> 
> I'm starting to be more convinced about Andrew's alternate patch, the
> "move LRU lock innermost and make it irq-safe".
> 
> Which also would make it saner to do the LRU handling inside
> __put_pages_ok() (and actually remove the BUG_ON(in_interrupt()) that
> Andrew had there in the old patch).

This would also make slablru easier.  We could just set the 'release me'
flag when slabs are chained to the free list.  In vmscan we make sure we
check if the page is referenced before the release logic.

Ed Tomlinson
