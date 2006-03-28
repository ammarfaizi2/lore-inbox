Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWC1L3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWC1L3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 06:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWC1L3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 06:29:13 -0500
Received: from wproxy.gmail.com ([64.233.184.227]:10412 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932194AbWC1L3L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 06:29:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BKnS5H1RmNj923VgLZ+vmFePupcg4hhHr3kQvTE9GktmhaV9Q1wCwg6afKkkN0jh+0j42RNU6UrN7OgAdVv2xNzHPO56z8Hmmj8Q7LSU5ELoeKZBN4cjmGbdCm039ELjTqWg4+c2ubrhNWzG8JrS1aQiDEQwRjiqmyPn3iouUCY=
Message-ID: <7d40d7190603280226l34f88a74y37fcc96ed60d53eb@mail.gmail.com>
Date: Tue, 28 Mar 2006 12:26:57 +0200
From: "Aritz Bastida" <aritzbastida@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ksoftird doesn't work like it should (?)
Cc: "Robert Olsson" <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

First of all, thank you all of you that helped me when i was doing my
thesis project: olsson, greg k-h, ... I could learn a lot (although
i'm still a newbie, of course) in these 8 months, and wrote in this
mailing list when i was too lost...

Well, you won't remember me, but I had to design a network analysis
system in kernel space. Letting apart that is or is not useful (I
didnt choose that, I just had to do it), I made some testing that
could be interesting, or that's what i think.

That's why I would like to share it with you. Here I attach a link to
a picture, which show the problems they happen when the network load
goes high.

http://www.flickr.com/photos/57861108@N00/119255818/

This picture shows the throughput of a network analysis system in user
space (not mine), with different injection speeds.
  x axis: traffic speed (packets per second)
  y axis: analyzer throughput (packets per second)

You can see that, when the network traffic is low, the network
analyzer can process all the packets (straight line), but when it gets
too high, it starts losing packets. If it gets even higher, the
ksoftirqd kernel thread starts eating 99.9% CPU time, even if it is
supposed that its priority is the lowest possible, so the throughput
goes lower. ksoftirqd is supposed that would not starve user programs,
but the system almost goes to livelock. The system stabilizes around
1.2 Gpps.

So what we can conclude here is that ksoftirqd doesnt work as it
should, or maybe do_softirq() is called from more places apart from
the ksoftird kernel thread. In any case, the user process almost
starves.

If you'd like, i have more pictures similar to this, and the
"solution" i found, which tries to make the throughput to be constant
independently of the traffic speed.

Regards
Aritz
