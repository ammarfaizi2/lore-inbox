Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSE1Kq1>; Tue, 28 May 2002 06:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSE1Kq0>; Tue, 28 May 2002 06:46:26 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50680 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313558AbSE1Kq0>; Tue, 28 May 2002 06:46:26 -0400
Subject: Re: Memory management in Kernel 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <acv5bj$m6$1@ID-44327.news.dfncis.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 12:49:21 +0100
Message-Id: <1022586561.4124.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 06:42, Andreas Hartmann wrote:
> > Well, if you can't fork a new process because that would push you into
> > overcommit, then you usually can't actually do anything useful on the
> > machine.
> 
> >From my experience with mode 2:
> 
> you can't do _anything_, if the overcommitment range has been reached. Even 
> running programms are crashing if they want to have some more memory. So, 
> new processes cannot be started and old processes cannot run and are 
> crashing as far as they want to have more memory. At last, there will be 
> only one user-process on the machine running - the bad programm, eating up 
> all the memory.

Are you sure you have it properly configured. Programs will only crash
if they demand more memory and don't properly handle out of memory
errors. No OOM kills occur. I've run simulated sets with large databases
and I don't see the problem you are reporting. There is a not quite
theoretical case where everything continues running but nothing quits
because it all has the memory it wants and there is not enough more. 

Also if an old program crashes, it frees memory so you have room for a
new one. With your fork bomb there is a likelyhood that a new fork will
beat others to the memory. 

Ultimately something has to die off or give back resources when it finds
it can't get any. There is a finite resource, you used it all. Going
beyond the current stuff to doing definable chargable subgroups with per
subgroup resource billing and optional overcommit rules is doable (thats
beancounter stuff again) but does require we add setluid/getluid
syscalls, tweak the PAM code in user space and merge the beancounter
stuff. At that point you can do really *cool* stuff like

	Staff have a guaranteed 75% of memory
	Students have a guaranteed 25% of memory but can take 50 if its 		there

And sit contented in the sure knowledge that if you fire up emacs on a
giant file as a staff member you'll only kick students off the box


Alan

