Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKAVOS>; Wed, 1 Nov 2000 16:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbQKAVOJ>; Wed, 1 Nov 2000 16:14:09 -0500
Received: from hermes.mixx.net ([212.84.196.2]:27410 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129055AbQKAVN4>;
	Wed, 1 Nov 2000 16:13:56 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Date: Wed, 01 Nov 2000 22:13:54 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A008792.BAA8F70D@innominate.de>
In-Reply-To: <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> <20001101023010.G13422@athlon.random> <20001031183809.C9733@.timpanogas.org> <20001101164106.F9774@athlon.random> <3A005217.88D2CA0D@timpanogas.org> <3A005476.17F0F253@timpanogas.org> <20001101190732.A19767@athlon.random> <3A00621F.7CC77F5A@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 973113234 19706 10.0.0.90 (1 Nov 2000 21:13:54 GMT)
X-Complaints-To: news@innominate.de
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test8 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> Andrea Arcangeli wrote:
> >
> > Speaking only for myself: on the technical side I don't think you can't be much
> > faster than moving the performance critical services into the kernel and by
> > skipping the copies (infact I also think that for fileserving skipping the
> > copies and making sendfile to work and to work in zero copy will be enough).
> > So I don't think losing robusteness this way can be explained in any technical
> > way and no, it's not by showing me money that you'll convince me that's a good
> > idea.
> 
> This would help, but not as much as full ring 0.

My experience is that I can get pretty much the same performance in ring
3 as ring 0 as long as I don't reload segment registers or take CR3.  Is
this right, or am I missing some fundamental kind of ring 3 overhead?

Even in ring 0, you can mostly protect processes from each other using
segments: if you don't reload the segments you can restrict damage to
your own segment.  It's not 100% safety but it is an enormous
improvement over running in the same address space as the OS kernel.  I
don't have any problem at all with the idea of running a lot of parallel
tasks in the same address space: the safety of this comes down to the
compiler you use to compile the processes.  If the compiler doesn't have
ops that let processes damage each other then you won't get damage,
assuming no bugs in your underlying implementation.

BTW, let me add my 'me too': go for it, there is obviously a pot of gold
there, just don't let Sauron^H^H^H^H^H^H Bill get to it first.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
