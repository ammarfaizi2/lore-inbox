Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTFKJt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTFKJt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:49:56 -0400
Received: from quechua.inka.de ([193.197.184.2]:4240 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264281AbTFKJtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:49:55 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: cachefs on linux
In-Reply-To: <200306101515.53464.rob@landley.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19Q2S2-0001J0-00@calista.inka.de>
Date: Wed, 11 Jun 2003 12:03:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200306101515.53464.rob@landley.net> you wrote:
> On Tuesday 10 June 2003 04:29, Sean Hunter wrote:
...
>> Its particularly handy for fast read-only NFS stuff.  We have thousands
>> of linux hosts and distributing software to all of them is a pain.  With
>> cachefs with NFS as the "back" filesystem, you push to the masters and
>> the clients get the changes over NFS and then store them in their local
>> cache so your software distribution nightmare becomes no problem at all.

This is not a good idea, unless you have a transactional semantic for the
fetches from the backend. Otherwise you have a mixture of old and new files.

>> Clients read off the local disk if they can, but fetch over NFS as
>> required.  You can tune the cache size on all of the client machines so
>> they can cache more or less of the most recently used NFS junk on its
>> local disk.

This is btw exactly what CODA and AFS does best.

> Technically cachefs is just a union mount with tmpfs or ramfs as the overlay 
> on the underlying filesystem.  Doing a seperate cachefs is kind of pointless 
> in Linux.

I think it is a bit different, since the cache is on disk and can be larger.
If you want to put that in swap space, you may quickly exceed some VM
limits. So there is a difference.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
