Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTKWL6B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 06:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTKWL6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 06:58:01 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:8906 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263364AbTKWL57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 06:57:59 -0500
Message-ID: <3FC0A0C2.90800@cyberone.com.au>
Date: Sun, 23 Nov 2003 22:57:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Andi Kleen <ak@colin2.muc.de>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       jbarnes@sgi.com, efocht@hpce.nec.com, John Hawkes <hawkes@sgi.com>,
       wookie@osdl.org
Subject: [RFC] generalise scheduling classes
References: <20031117021511.GA5682@averell> <3FB83790.3060003@cyberone.com.au> <20031117141548.GB1770@colin2.muc.de> <Pine.LNX.4.56.0311171638140.29083@earth> <20031118173607.GA88556@colin2.muc.de> <Pine.LNX.4.56.0311181846360.23128@earth> <20031118235710.GA10075@colin2.muc.de> <3FBAF84B.3050203@cyberone.com.au> <501330000.1069443756@flay> <3FBF099F.8070403@cyberone.com.au> <1010800000.1069532100@[10.10.2.4]> <3FC01817.3090705@cyberone.com.au>
In-Reply-To: <3FC01817.3090705@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
We still don't have an HT aware scheduler, which is unfortunate because
weird stuff like that looks like it will only become more common in future.

I made a patch on top of my recent NUMA/SMP scheduling stuff to implement
generalised scheduling classes. With this modification we can allow
architectures to control scheduling policy in a much finer way.
Hyperthreading should be no problem, hierarchical (NUMA) nodes should
be doable as well.

I'm not exactly sure how architecuture specific code is supposed to be
handled, I'll have to have a look at some examples. Basically architectures
build up your own scheduling "classes".

I have supplied a default function to build up the classes if none is
supplied. It builds them so functionality should be similar to the
previous standard local / remote behaviour.

Haven't done much testing yet, just asking for comments. Will these
classes be sufficient for everyone?

Class is struct sched_class in include/linux/sched.h
Default classes are built by arch_init_sched_classes in kernel/sched.c

http://www.kerneltrap.org/~npiggin/w23/
The patch in question is this one
http://www.kerneltrap.org/~npiggin/w23/broken-out/sched-domain.patch

Best regards,
Nick


