Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261494AbSJDFH3>; Fri, 4 Oct 2002 01:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSJDFH3>; Fri, 4 Oct 2002 01:07:29 -0400
Received: from [204.248.145.126] ([204.248.145.126]:34728 "HELO mail.lig.net")
	by vger.kernel.org with SMTP id <S261494AbSJDFH1>;
	Fri, 4 Oct 2002 01:07:27 -0400
Message-ID: <3D9D2354.3090807@lig.net>
Date: Fri, 04 Oct 2002 01:12:52 -0400
From: "Stephen D. Williams" <sdw@lig.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen D. Williams" <sdw@lig.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rsync SSH session hang, AGAIN  -  cancel
References: <3D99B60C.20303@lig.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't think any of the tools that I know, trust, and have used for 
years could be failing me, but I hadn't seen quite this failure mode before.

Even though the 'old' system below was reachable via web, ssh command 
line sessions, etc., any connection between it and another box on the 
same network at the ISP failed after 100-200KB.  While there were a few 
ethernet errors, nothing seemed to increase much or at all with each ssh 
hang.  Nevertheless, it was either a cable or hub/switch at the ISP that 
was bad.  I now theorize that, having a noisy port, the hub/switch 
involved would sense an unacceptably bad port and shut it down, but only 
when burst transfers were between local boxes.  Everything remote was 
spaced enough to be below that threshold.  After a few seconds of no 
activity, the port was apparently unlocked.  I knew that switches had 
bad port sensing, but had never seen a system on the fence like this. 
 It didn't help that these machines were 500 miles away in a colo with 
only daytime staff.

Apologies for the premature post.
sdw

Stephen D. Williams wrote:

> This has been a recurring problem for a couple years which I and 
> others have experienced.  I was free from it for a while, but after 
> upgrading OpenSSL/OpenSSH to avoid the recent exploit it is back and 
> highly repeatable.  This has been persistant enough that I am going to 
> start with the assumption that it may be a kernel bug, or at least 
> probably debuggable definitively only by a proficient kernel 
> developer.  We have got to squash this once and for all; SSH is used 
> everywhere and it needs to be reliable.  Probably there is a race 
> condition in ssh, as mentioned below, but it must be subtle.
>
> rsync/ssh transfers from local system to local system work perfectly. 
> Between the systems, there is nearly always large delays at certain 
> times and usually a complete hang.  After a long period, this often 
> produces a timeout.  These sytems are on 100baseT on the same switch. 
> One system appears to be having mild packet loss (400 out of 400,000 
> on both send and receive as frame/carrier erros).  BTW, running a cpio 
> through the SSH connections causes a nearly immediate hang, so it is 
> unlikely to be a problem with rsync.
>
> Both systems work find receiving rsync/ssh from my laptop over a 400Kb 
> DSL connection with:
> OpenSSH 3.1p1
> openssl 0.9.6c
> rsync 2.5.4
> gcc 2.96
> kernel 2.4.19
>
> (systems are a combination of Suse and Redhat 7.3, upgraded variously 
> by hand)
>
> My standard rsync/ssh script looks like:
>
> brsyncndz (backup rsync no delete or compression):
> #!/bin/sh
> if [ "$PORT" = "" ]; then PORT=22; fi
> rsync -vv -HpogDtSxlra --partial --progress --stats -e "ssh -p $PORT" $*
>
> On both sides:
> OpenSSL-0.9.6g
> Openssh-3.4p1
> rsync-2.5.5
>
> On 'old' system:
> gcc 2.95.2
> kernel 2.4.3
>
> On 'new' system:
> gcc 2.96
> kernel 2.4.20-pre8
>
>
> References to past discussions:  (Tried the TCP buffers tuning.)
> http://lists.insecure.org/linux-kernel/2001/Mar/0374.html
> http://lists.insecure.org/linux-kernel/2001/Mar/0380.html
> http://lists.insecure.org/linux-kernel/2001/Mar/0400.html
> Haven't tried this code yet:
> http://lists.insecure.org/linux-kernel/2001/Mar/0652.html
>
> Thanks!
> sdw




