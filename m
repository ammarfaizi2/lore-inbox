Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265756AbRFXW1C>; Sun, 24 Jun 2001 18:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265740AbRFXW0w>; Sun, 24 Jun 2001 18:26:52 -0400
Received: from jalon.able.es ([212.97.163.2]:27019 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S265756AbRFXW0d>;
	Sun, 24 Jun 2001 18:26:33 -0400
Date: Mon, 25 Jun 2001 00:30:02 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: landley@webofficenow.com
Cc: "J . A . Magallon" <jamagallon@able.es>, landley@webofficenow.com,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Timur Tabi <ttabi@interactivesi.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010625003002.A1767@werewolf.able.es>
In-Reply-To: <Pine.LNX.3.96.1010622162213.32091B-100000@artax.karlin.mff.cuni.cz> <0106220929490F.00692@localhost.localdomain> <20010624234101.A1619@werewolf.able.es> <01062412555901.03436@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <01062412555901.03436@localhost.localdomain>; from landley@webofficenow.com on Sun, Jun 24, 2001 at 18:55:59 +0200
X-Mailer: Balsa 1.1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010624 Rob Landley wrote:
>
>This is a bit like like saying that a truck and a train are totally different 
>beasts.  If I'm trying to haul cargo from point A to point B, which is served 
>by both, all I care about is how long it takes and how much it costs.
>
>I don't care what it was INTENDED to do.  A rock makes a decent hammer.  So 
>does a crescent wrench.  The question is how good a tool is it for the uses 
>we're trying to put it to?
>

Well, the problem is that when somebody says you it has a truck to take your
cargo, you have your idea of a truck, and there is a standard idea of
the difference between a train and a truck.

Tools have been developed for multi-processing in unix, processes and threads.
And have a difference. And when you design your algorithm (and more if you
want it to be protable), you think if you want it done with processes or
you need threads (posix, or lwps or whatever). And you decide it on the
standard idea of what a process and a thread are.

Take a programmer comming from other system to linux. If he wants multi-
threading and protable code, he will choose pthreads. And you say to him:
do it with 'clone', it is better. Answer: non protable. Again: do it
with fork(), it is fast in linux. Answer: better for linux, but it is a
real pain in other systems.

And worst, you are allowing people to program based on a tool that will give
VERY diferent performance when ported to other systems. They use fork().
They port their app to solaris. The performance sucks. It is not Solaris
fault. It is linux fast fork() that makes people not looking for the
correct standard tool for what they want todo.

Instead of trying to enhance linux thread support, you try to move programmes
to use linux 'specialities'.

>> This remembers on other question I read in this thread (I tried to answer
>> then but I had broke balsa...). Somebody posted some benchmarks of linux
>> fork()+exec() vs Solaris fork()+exec().
>
>What programs does this make a difference in?  These are tools meant to be 
>used.  What real-world usage causes them to differ?  If a reasonably 
>competent programmer ported a program from one platform to another, is this 
>the behavior they would expect to see (without a major rewrite of the code)?
>
>> That is comparing apples and oranges.
>
>Show me a real-world program that makes the distinction you're making.  
>Something in actual use.
>

shell scripting, for example. Or multithreaded web servers. With the above
test (fork() + immediate exec()), you just try to mesaure the speed of fork().
Say you have a fork'ing server. On each connection you fork and exec the
real transfer program. There time for fork matters. It can run very fast
in Linux but suck in other systems. Just because the programmer chose fork()
instead of vfork().

>> The clean battle should be linux fork-exec vs vfork-exec in
>> Solaris, because for in linux is really a vfork in solaris.
>
>But the point of threading is it's a fork WITHOUT an exec.
>

Not always, see above.

>
>I'm not going to comment on the difference between fork and vfork becaue to 
>be honest I've forgotten what the difference is.  Something to do with 

Time.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac17 #2 SMP Fri Jun 22 01:36:07 CEST 2001 i686
