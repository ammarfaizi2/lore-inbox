Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271940AbRIUIdY>; Fri, 21 Sep 2001 04:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272080AbRIUIdO>; Fri, 21 Sep 2001 04:33:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62299 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271940AbRIUIdH>; Fri, 21 Sep 2001 04:33:07 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Rob Fuller <rfuller@nsisoftware.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L.0109192000050.19147-100000@imladris.rielhome.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Sep 2001 02:23:15 -0600
In-Reply-To: <Pine.LNX.4.33L.0109192000050.19147-100000@imladris.rielhome.conectiva>
Message-ID: <m1wv2t7y18.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 19 Sep 2001, Eric W. Biederman wrote:
> 
> > That added to the fact that last time someone ran the numbers linux
> > was considerably faster than the BSD for mm type operations when not
> > swapping.  And this is the common case.
> 
> Optimising the VM for not swapping sounds kind of like
> optimising your system for doing empty fork()/exec()/exit()
> loops ;)

Swapping is an important case.  But 9 times out of 10 you are managing
memory in caches, and throwing unused pages into swap.  You aren't busily
paging the data back an forth.  But if I have to make a choice in
what kind of situation I want to take a performance hit, paging
approaching thrashing or a system whose working set size is well
within RAM.  I'd rather take the hit in the system that is paging.

Further fast IPC + fork()/exec()/exit() that programmers can count on
leads to more robust programs.  Because different pieces of the program
can live in different processes.  One of the reasons for the stability
of unix is that it has always had a firewall between it's processes so
one bad pointer will not bring down the entire system.   

Besides I also like to run a lot of shell scripts, which again stress
the fork()/exec()/exit() path.

So no I don't think keeping those paths fast is silly.

I also think that being able to get good memory usage information is
important.  I know that reverse maps make that job easier.  But just
because the make an important case easier to get write I don't think
reverse maps are a shoe in. 

Eric




