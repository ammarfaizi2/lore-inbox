Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSHFVFw>; Tue, 6 Aug 2002 17:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSHFVFu>; Tue, 6 Aug 2002 17:05:50 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:37512 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316043AbSHFVFL>; Tue, 6 Aug 2002 17:05:11 -0400
Message-Id: <5.1.0.14.2.20020806135501.09799218@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 06 Aug 2002 14:08:37 -0700
To: kuznet@ms2.inr.ac.ru
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: "new style" netdevice allocation patch for TUN driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208062034.AAA25662@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I completely agree. However sleeping and holding a lock that you
> > don't have to hold
>
>Nope. We have to hold it. Lock are taken to be held. :-)
Device is already unlinked and is not visible to the rest of the stack.
Please explain to me why do we have to hold rtnl lock while sleeping in
unregister_netdevice ?

>Anyway, if you found real problem, it would be better if
>you explained what is this, instead of proposing some random hacks.
Come on it's not a random hack, there are two problems.

1 - Something is not releasing device during deregistration
I have no idea which subsystem is doing that. I'm not the one
who brought that up. This needs to be fixed somehow. I personally
can't reproduce it.

2 - We're sleeping with the rntl_lock held
This is somewhat unrelated to #1. I don't see the reason why we shouldn't
fix it. If one thing is buggy it doesn't mean that we should halt the
whole stack. And that's exactly what we're do right now. Devices, routes,
etc cannot be added/removed while unregister_netdevice is waiting.

Max

