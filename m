Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVBCAEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVBCAEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVBBXxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:53:00 -0500
Received: from gizmo04ps.bigpond.com ([144.140.71.14]:15284 "HELO
	gizmo04ps.bigpond.com") by vger.kernel.org with SMTP
	id S262611AbVBBXqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:46:46 -0500
Message-ID: <42016661.80908@bigpond.net.au>
Date: Thu, 03 Feb 2005 10:46:41 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Davis <paul@linuxaudiosystems.com>
CC: "Bill Huey (hui)" <bhuey@lnxw.com>, "Jack O'Quin" <joq@io.com>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200502022303.j12N3nZa002055@localhost.localdomain>
In-Reply-To: <200502022303.j12N3nZa002055@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis wrote:
>>As Ingo said in an earlier a post, with a little ingenuity this problem 
>>can be solved in user space.  The programs in question can be setuid 
>>root so that they can set RT scheduling policy BUT have their 
>>permissions set so that they only executable by owner and group with the 
>>group set to a group that only contains those users that have permission 
>>to run this program in RT mode.  If you wish to allow other users to run 
>>the program but not in RT mode then you would need two copies of the 
>>program: one set up as above and the other with normal permissions.
> 
> 
> Just a reminder: setuid root is precisely what we are attempting to
> avoid. 

There's nothing wrong with using setuid root if you do it carefully and 
properly.  If you have the sources to the program then you can place all 
the necessary safeguards in the program itself.  Doing this inside the 
program would allow more elaborate control over who is allowed to set RT 
policy from within the program.  E.g. you could have a file (owned by 
root and only writable by root) in /etc with the names of the users that 
have this privilege.  If this file does not exist, has the wrong 
privileges or the user associated with task's ruid is not in the file 
then the the program immediately and irrevocably drops root privileges 
otherwise it drops them temporarily and regains them when it needs to 
either change policy to RT or fork another task that needs the same 
privileges.

> 
> 
>>If you have the source code for the programs then they could be modified 
>>to drop the root euid after they've changed policy.  Or even do the 
> 
> 
> This is insufficient, since they need to be able to drop RT scheduling
> and then reacquire it again later.

I believe that there are mechanisms that allow this.  The setuid man 
page states that a process with non root real uid but setuid as root can 
use the seteuid call to use the _POSIX_SAVED_IDS mechanism to drop and 
regain root privileges as required.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
