Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129932AbQKLD77>; Sat, 11 Nov 2000 22:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbQKLD7t>; Sat, 11 Nov 2000 22:59:49 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:1013 "EHLO
	tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S129903AbQKLD7i>; Sat, 11 Nov 2000 22:59:38 -0500
From: Jesse Pollard <pollard@cats-chateau.net>
Reply-To: pollard@cats-chateau.net
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Date: Sat, 11 Nov 2000 22:44:07 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org> <8uji8q$1ru$1@forge.tanstaafl.de> <20001111111159.C9464@vger.timpanogas.org>
In-Reply-To: <20001111111159.C9464@vger.timpanogas.org>
MIME-Version: 1.0
Message-Id: <00111122574200.06438@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Jeff V. Merkey wrote:
>On Sat, Nov 11, 2000 at 01:40:42PM +0000, Henning P. Schmiedehausen wrote:
>> jmerkey@timpanogas.org (Jeff V. Merkey) writes:
>> 
>> 
>> >We got to the bottom of the sendmail problem.  The line:
>> 
>> > -O QueueLA=20 
>> 
>> >and
>> 
>> > -O RefuseLA=18
>> 
>> >Need to be cranked up in sendmail.cf to something high since the
>> >background VM on a very busy Linux box seems to exceed this which causes
>> >large emails to get stuck in the /var/spool/mqueue directory for long
>> >periods of time.  Since vger is getting hammered with FTP all the time,
>> >and is rarely idle.  This also explains what Richard was seeing with VM
>> >thrashing in a box with low memory.  
>> 
>> So what? This is written in the documentation of the program? You do read
>> documentation, do you?
>> 
>> >The problem of dropping connections on 2.4 was related to the O RefuseLA
>> >settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
>> >clearly set too low for modern Linux kernels.  You may want them cranked
>> >up to 100 or something if you want sendmail to always work.  
>> 
>> These settings are for single user / small user numbers boxes.
>> 
>> If you're using an out of the vendor box distribution configuration
>> for a high traffic server, you're nuts. Or ignorant. Or dumb. Or your
>> consultant is an idiot.
>> 
>> 	Regards
>> 		Henning
>
>
>I guess all customers are idiots then, since about 100+ people who were
>using our release downloaded it, and had these problems with sendmail.  This
>disconnect of yours is about what I would expect from someone in a University.
>Some of us don't have the luxury of being able to pontificate in a Univ
>environment -- we have to make a living from Linux -- and provide payroll
>for the people on this list who actually do the core work on Linux.  
>
>If there were not a commercialization effort around Linux, it would still
>be unknown, like TMOK or a lot of other kernels sitting in universities
>somewhere not being deployed.  It's the commercialization effort that made
>Linux a household word.  NT and NetWare servers don't stop forwarding 
>emails when the load average gets too high -- they just work out of the
>box, and hopefully, no so will Linux (our distribution does now since 
>this problem in fixed).
>
>Now we know that sendmail has problems on Linux based on the this load
>average interpretation, which we would not have known if someone had 
>not raised the issue.  

This is not a problem with sendmail on Linux. The same thing will happen
on ANY uni-processor system (multi-processor too, but not as severe).

I run sendmail on an SGI Indy (yes, that no-longer-manufactured thing) and
it is necessary to set the load average on it to 75 or so. As high as 150
is not unreasonable either. This system handles 10's of thousands of mail
messages per day.

This is only a matter of tuning sendmail to do what you want, when you want.
It is also reasonably well documented in the sendmail distribution. You do
have to monitor the system to determine what "high" really is.

In the case of the NT servers, I have seen them choke (and crash) since they
DON'T seem to throttle very well.

BTW, After I read the sendmail documentation, and observed the system for
a while, I decided to count the sendmail "loadaverage" as really being the
average number of simultaneous connections (sendmail processes/threads).
This leads to the choice of "how many do I want active, and how many do
I want to suspended, and when do I want to refuse connection". THEN I add
the number of other active processes to the proposed limits.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@cats-chateau.net

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
