Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVBOBp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVBOBp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVBOBp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:45:58 -0500
Received: from smtpout.mac.com ([17.250.248.83]:56293 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261562AbVBOBpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:45:49 -0500
In-Reply-To: <1108430245.32293.16.camel@krustophenia.net>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net> <20050211011609.GA27176@suse.de> <1108354011.25912.43.camel@krustophenia.net> <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de> <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com> <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Patrick McFarland <pmcfarland@downeast.net>, linux-kernel@vger.kernel.org,
       Tim Bird <tim.bird@am.sony.com>, Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Roland Dreier <roland@topspin.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001 release)
Date: Mon, 14 Feb 2005 20:45:39 -0500
To: Lee Revell <rlrevell@joe-job.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 14, 2005, at 20:17, Lee Revell wrote:
> On Mon, 2005-02-14 at 16:16 -0800, Tim Bird wrote:
>> Lee Revell wrote:
>>> But, I was referring more to things like GDM not being started until 
>>> all
>>> the other init scripts are done.  Why not start it first, and let the
>>> network initialize while the user is logging in?
>>
>> There are a number of techniques used by CE vendors to get fast bootup
>> time.  Some CE products boot Linux in under 1 second.  Sony's
>> best Linux boot time in the lab (from power on to user space)
>> was 148 milliseconds, on an ARM chip (running at 200 MHZ I believe).
>
> The reason I marked by response OT is that the time from power on to
> userspace does not seem to be a big problem.  It's the amount of time
> from user space to presenting a login prompt that's way too long.  My
> distro (Debian) runs all the init scripts one at a time, and GDM is the
> last thing that gets run.  There is just no reason for this.  We should
> start X and initialize the display and get the login prompt up there
> ASAP, and let the system acquire the DHCP lease and start sendmail and
> apache and get the date from the NTP server *in the background while I
> am logging in*.  It's not rocket science.

Such a system needs a drastically different bootup process than 
currently
exists, including the ability to specify init-script dependencies.  
(Like
for example user login via GDM (and with our setup, GDM working at all)
requires that AFS is mounted and NIS is working, which both require the
network to be available, which requires...  You can see where this is
going.  I think eventually we need a better /sbin/init, one that can use
a traditional legacy /etc/inittab file in addition to a newfangled
simultaneous boot process with lots of ways to start various kinds of
services.  Unfortunately such a system will need a _LOT_ of work and
testing to make sure it doesn't break existing setups.  Oh well, I can
dream, can't I? :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


