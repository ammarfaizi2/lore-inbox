Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSHBJMp>; Fri, 2 Aug 2002 05:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318759AbSHBJMp>; Fri, 2 Aug 2002 05:12:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17413 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317752AbSHBJMo>; Fri, 2 Aug 2002 05:12:44 -0400
Message-ID: <3D4A4CA3.4050803@evision.ag>
Date: Fri, 02 Aug 2002 11:10:59 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Martin Dalecki <dalecki@cs.net.pl>, linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
References: <Pine.GSO.4.21.0208011840130.12627-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Thu, 1 Aug 2002, Linus Torvalds wrote:
> 
> 
>>You probably saw this. Looks like blocksize has been buggered somehow.
>>Apparently Petr has a 1kB blocksize optical device..
> 
> 
> Yeah - with partition boundaries set not on a physical sector boundary ;-/
> 
> He's actually lucky that beginning of partition was not in the middle of
> a physical sector...
> 
> Looks like we need
> 	a) accurate hardsect_size for these beasts (which is a problem
> with current setup, since it's per-queue and not per-device; master and
> slave can have different hardsect sizes).

FYI: In the ATA driver area all queues *are* explicitely per device.

> 	b) extra check in check_partitions() that would verify that
> partition doesn't end in the middle of a sector (and round it down
> if it does).
> 
> Basically, old code worked by accident on that setup - Petr had half-Kb
> in the end of partition unaccessible and do_open() didn't notice that.
> Now it does and tries to give such access.  Disk is not happy...


