Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266871AbUHSRmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266871AbUHSRmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUHSRlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:41:45 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:51961 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S266850AbUHSRlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:41:09 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, rol@as2917.net
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Thu, 19 Aug 2004 13:41:07 -0400
User-Agent: KMail/1.6.82
Cc: "'Matthias Andree'" <matthias.andree@gmx.de>, "'Martin Mares'" <mj@ucw.cz>,
       "'Joerg Schilling'" <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com
References: <200408191600.i7JG0Sq25765@tag.witbe.net>
In-Reply-To: <200408191600.i7JG0Sq25765@tag.witbe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200408191341.07380.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.62.54] at Thu, 19 Aug 2004 12:41:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 12:00, Paul Rolland wrote:
>Hello,
>
>> FWIW, I had to use smake, latest version from his site, in order
>> to compile 2.01a37 just yesterday.  The error messages from make
>> (very carefully programmed into the Makefile) indicated that the
>> lost headers it couldn't find were a bug in make-3.80, and that
>> his make suffered from no such errors.  It didn't.
>>
>> Since the gnu make has only had, what, 2, maybe 3 revisions in
>> almost a decade, maybe, just maybe, there is a grain of truth to
>> Jorg's objections and often childish squawking, at least over the
>> gnu make which he has mentioned, among others.
>
>I did compile the cdrecord 2.01a37 on my machine no later than
>yesterday.
>I was running my 2.6.8.1 kernel, and make says :
>GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.
>Built for i386-redhat-linux-gnu
>Copyright (C) 1988, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 2000
>        Free Software Foundation, Inc.
>This is free software; see the source for copying conditions.
>There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>PARTICULAR PURPOSE.
>
>Report bugs to <bug-make@gnu.org>.
>
Humm, I got many many losses of header stuff messages from:
[root@coyote cdrecord]# make --version
GNU Make 3.80
Copyright (C) 2002  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

So apparently 3.80 is a regression in this case.

But, please note, your 3.79-1 is dated 2000, and my 3.80 is dated 
2002.  That to me says its all but abandoned.  Granted, its "mature" 
in that its been around for what, 30 years?  Still, when a needed 
facility was broken 2+ years ago according to these tests, why hasn't 
it since been fixed?

We seem to have an attitude that if it can build a kernel, what else 
does it need? :(

>Build process was really fine, no error was reported, and I don't
> have any smake stuff on my machine :
>17 [17:58] rol@donald:~/install/cdrtools-2.01a37> smake
>smake: Command not found.
>
>> [root@coyote cdrecord]# cdrecord --version
>> Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004
>> Jörg Schilling
>> cdrecord: Warning: Running on Linux-2.6.8-rc4
>> cdrecord: There are unsettled issues with Linux-2.5 and newer.
>> cdrecord: If you have unexpected problems, please try Linux-2.4 or
>> Solaris.
>>
>> However Jorg, since I built from your tarball, and used smake to
>> do it, why is it now proclaiming to be a "Clone".
>
>Seems to be only related to the -clone option if you look at the
> code, and it indicates the feature has been compile :
>#ifdef  CLONE_WRITE
>        error("\t-clone         Write disk in clone write mode.\n");
>#endif
>
>Regards,
>Paul
>
>Paul Rolland, rol(at)as2917.net
>ex-AS2917 Network administrator and Peering Coordinator
>
However, here is a rather interesting tidbit to the ongoing saga of me 
trying to avoid the linux equ of the infamous BSOD.

The last time I was playing in the bios, I turned off the "external 
cache".  Well, the machine is so slow as to be almost unusable (it 
may be 30+ seconds between my typing, and seeing it on the screen, 
spamassassin in particular is having cpu for lunch!), and I expected 
that, BUT!!!!!!  The normal gnu make just made it from an "smake 
clean" tate, WITHOUT ERRORS or warnings of any kind being reported.  
But it, and yet another kernel remake took about 3x their normal 
amounts of time, as in 18 minutes to build a 6 minute kernel.

And it didn't fix the --version output either:
[root@coyote cdrtools-2.01]# cdrecord/OBJ/athlon-linux-cc/cdrecord 
--version
Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004 
Jörg Schilling
cdrecord/OBJ/athlon-linux-cc/cdrecord: Warning: Running on 
Linux-2.6.8-rc4
cdrecord/OBJ/athlon-linux-cc/cdrecord: There are unsettled issues with 
Linux-2.5 and newer.
cdrecord/OBJ/athlon-linux-cc/cdrecord: If you have unexpected 
problems, please try Linux-2.4 or Solaris.

Now I am wondering if linux is truely aware of what memory the bios 
may be setting up as L2 cache when its enabled, and the processor and 
linux are fighting over memory they both *think* they own?  And it 
darn sure waddles and quacks like this sort of a duck.

I'm about to reboot to 2.6.8.1-mm2 and move on, but I have to ask 
everyone if I just stumbled over a clue to my dcache/icache/buffer 
problems while sitting here in the intellectual dark.  I think it 
bears a bit of investigation from the near total lack of clues that 
point to an actual (heaven forbid, errk) fixed location bug, hardware 
or software...

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
