Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTBTQ6v>; Thu, 20 Feb 2003 11:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTBTQ6v>; Thu, 20 Feb 2003 11:58:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60937 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266120AbTBTQ6u>; Thu, 20 Feb 2003 11:58:50 -0500
Date: Thu, 20 Feb 2003 09:06:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Alex Larsson <alexl@redhat.com>,
       <procps-list@redhat.com>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <Pine.LNX.4.44.0302201656030.30000-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302200902260.2493-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Ingo Molnar wrote:
>
> the main problem with threads in /proc is that there's a big slowdown when
> using lots of threads.

Well, part of the problem (I think) is that you added all the threads to 
the same main directory.

Putting a "." in front of the name doesn't fix the /proc level directory
scalability issues, it only means that you can avoid some of the user- 
level scalability ones.

So to offset that bad design, you then add other cruft, like the lookup
cursor and the "." marker. Which is not a bad idea in itself, but I claim
that if you'd made the directory structure saner you wouldn't have needed
it in the first place.

It would just be _so_ much nicer if the threads would show up as 
subdirectories ie /proc/<tgid>/<tid>/xxx. More scalable, more readable, 
and just generally more sane.

		Linus

