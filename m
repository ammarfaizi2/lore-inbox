Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276587AbRJHIo7>; Mon, 8 Oct 2001 04:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276775AbRJHIot>; Mon, 8 Oct 2001 04:44:49 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:5028 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S276587AbRJHIon>; Mon, 8 Oct 2001 04:44:43 -0400
Message-ID: <3BC16632.4040008@antefacto.com>
Date: Mon, 08 Oct 2001 09:39:14 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Alex Larsson <alexl@redhat.com>, Ulrich Drepper <drepper@cygnus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <m3r8slywp0.fsf@myware.mynet> <Pine.LNX.4.33.0110031111470.29619-100000@devserv.devel.redhat.com> <20011003232609.A11804@gruyere.muc.suse.de> <3BBDAB24.7000909@antefacto.com> <20011005150144.A11810@gruyere.muc.suse.de> <3BBDB26D.2050705@antefacto.com> <20011005163807.A13524@gruyere.muc.suse.de> <3BBDCAF8.6070705@antefacto.com> <20011005211235.A16163@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>On Fri, Oct 05, 2001 at 04:00:08PM +0100, Padraig Brady wrote:
>
>>Andi Kleen wrote:
>>
>>>>>Another advantage of using the real time instead of a counter is that 
>>>>>you can easily merge the both values into a single 64bit value and do
>>>>>arithmetic on it in user space. With a generation counter you would need 
>>>>>to work with number pairs, which is much more complex. 
>>>>>
>>>>??
>>>>if (file->mtime != mtime || file->gen_count != gen_count)
>>>>    file_changed=1;
>>>>
>>>And how would you implement "newer than" and "older than" with a generation
>>>count that doesn't reset in a always fixed time interval (=requiring
>>>additional timestamps in kernel)?  
>>>
>>>-Andi
>>>
>>Well IMHO "newer than", "older than" applications have until now
>>done with second resolution, and that's all that's required?
>>
>
>No they haven't. GNU make supports nsec mtime on Solaris and apparently
>some other OS too, because the second granuality mtime can be a big 
>problem with make -j<bignumber> on a big SMP box. make has to distingush
>"is older" from "is newer"; "not equal" alone doesn't cut it.
>
>[If you think it is modify your make to replace the "is older" check
>for dependencies with "is not equal" and see what happens]
>

OK agreed, in this case the, complete state/relationship between files, 
must be
maintained independently of the userspace app, i.e. in the filesystem. 
But wont
you then have the same problem with synchronising nanosecond times between
the various processors (which could be the other side of a network cable 
in some
configurations)? So perhaps the best solution is to maintain both a 
generation
count which would do for many apps who just care if the file has changed 
relative
to some moment it time and not relative to another file(s) on the 
filesystem .
Then for make type applications you could maintain the full resolution 
timestamp,
however this will still have the synchronisation/portability/CPU expense 
issues
discussed previously.

Padraig.

