Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316876AbSE1SL6>; Tue, 28 May 2002 14:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316877AbSE1SL5>; Tue, 28 May 2002 14:11:57 -0400
Received: from mout0.freenet.de ([194.97.50.131]:12511 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S316876AbSE1SLz>;
	Tue, 28 May 2002 14:11:55 -0400
Message-ID: <3CF3C8F4.8040400@athlon.maya.org>
Date: Tue, 28 May 2002 20:14:12 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <fa.n12rl6v.9644rg@ifi.uio.no> <fa.jd9c9pv.190gl8n@ifi.uio.no> 	<acv5bj$m6$1@ID-44327.news.dfncis.de> <1022586561.4124.39.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2002-05-28 at 06:42, Andreas Hartmann wrote:
> 
>>>Well, if you can't fork a new process because that would push you into
>>>overcommit, then you usually can't actually do anything useful on the
>>>machine.
>>
>>>From my experience with mode 2:
>>
>>you can't do _anything_, if the overcommitment range has been reached. Even 
>>running programms are crashing if they want to have some more memory. So, 
>>new processes cannot be started and old processes cannot run and are 
>>crashing as far as they want to have more memory. At last, there will be 
>>only one user-process on the machine running - the bad programm, eating up 
>>all the memory.
> 
> 
> Are you sure you have it properly configured. Programs will only crash
> if they demand more memory and don't properly handle out of memory
> errors.

I don't know, if they properly handle out of memory errors. It have been 
X-programms.
Logon wasn't able either with login nor with ssh from remote (sshd 
couldn't fork).

> No OOM kills occur.

That's definitly right.

> I've run simulated sets with large databases
> and I don't see the problem you are reporting. There is a not quite
> theoretical case where everything continues running but nothing quits
> because it all has the memory it wants and there is not enough more. 

A process which doesn't need any more memory is running well. In 
consoles, on which I have been logged in, I could roll through the last 
commands without any problem - but I couldn't start a new process.

> Also if an old program crashes, it frees memory so you have room for a
> new one.

The memory wich has been freed is eaten up from the malicious program. 
It's very easy to reproduce it with the program I linked to in my first 
posting.

> With your fork bomb there is a likelyhood that a new fork will
> beat others to the memory. 

That's it. And if there is a program running with such a malfunction the 
machine can't do anything more. If a hacker wants to block your machine, 
he can do it without beeing root.

> Ultimately something has to die off or give back resources when it finds
> it can't get any. There is a finite resource, you used it all. Going
> beyond the current stuff to doing definable chargable subgroups with per
> subgroup resource billing and optional overcommit rules is doable (thats
> beancounter stuff again) but does require we add setluid/getluid
> syscalls, tweak the PAM code in user space and merge the beancounter
> stuff. At that point you can do really *cool* stuff like
> 
> 	Staff have a guaranteed 75% of memory
> 	Students have a guaranteed 25% of memory but can take 50 if its	there
> 
> And sit contented in the sure knowledge that if you fire up emacs on a
> giant file as a staff member you'll only kick students off the box

I think, that's what would be best. Ressources are given to groups and 
they must work with. There isn't any more for them - the rest is for 
sysadmins to ensure that they always can successfully control the 
machine and can kill malicious processes. No external reachable daemon 
must be running in the sysadmin ressource-group.

I think it's something like ressource-management on IBM's S390.


Regards,
Andreas Hartmann

