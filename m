Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288634AbSADN4M>; Fri, 4 Jan 2002 08:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288635AbSADN4D>; Fri, 4 Jan 2002 08:56:03 -0500
Received: from sgie000400.kiv-webservice.de ([195.226.81.253]:24327 "EHLO
	irc.kiv-host.de") by vger.kernel.org with ESMTP id <S288634AbSADNzo> convert rfc822-to-8bit;
	Fri, 4 Jan 2002 08:55:44 -0500
Message-ID: <4353BABFDF95D311BFC30004AC4CB22AAE343F@sdar000001.kiv-da.de>
From: "Stolle, Martin (KIV)" <MStolle@kiv.de>
To: "'Ken Brownfield'" <brownfld@irridia.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: AW: [2.4.17/18pre] VM and swap - it's really unusable
Date: Fri, 4 Jan 2002 11:19:10 +0100 
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my case, I've got the same problems. 
I had a long time with testing, but without success.
With the help of your Mailing-Group i found out, that the 
-aa kernels are better in stability.

The -aa kernels are slower, but stable, especially with large informix
databases.

This is very important for me, because i have an important production
environment,
in which reboot wouldn't be tolerable.

Greetings

Martin

-----Ursprüngliche Nachricht-----
Von: Ken Brownfield [mailto:brownfld@irridia.com]
Gesendet: Freitag, 4. Januar 2002 06:26
An: Stephan von Krawczynski
Cc: linux-kernel@vger.kernel.org
Betreff: Re: [2.4.17/18pre] VM and swap - it's really unusable


On Fri, Jan 04, 2002 at 01:19:28AM +0100, Stephan von Krawczynski wrote:
| > A) VM has major issues                                              
|                                                                       
| On all boxes I run currently (all 1GB or below RAM), I cannot find    
| _major_ issues.                                                       

Yeah, I'm seeing it primarily with 1-4GB, though I have very few <1GB
machines in production.

| > 2) VM falls down on large-memory machines with a                    
| >    high inode count (slocate/updatedb, i/dcache)                    
|                                                                       
| Must be beyond the GB range.                                          

The critical part is the high inode count -- memory amount increases the
severity rather than triggering the problem.

| > 3) Memory allocation failures and OOM triggers                      
| >    even though caches remain full.                                  
|                                                                       
| I have not had one up to now in everyday life with 2.4.17             

I'm seeing this in malloc()-heavy apps, but fairly sporadic unless I
create a test case.  On desktops, most of these issues disappear, but I
do think the mindset behind the kernel needs to at least partially break
free of the grip of UP desktops, at least to the point of fixing issues
like I'm mentioning.

Not critical for me; but high-profile on lkml.

[...]
| > C) IO-APIC code that requires noapic on any and all SMP             
| >   machines that I've ever run on.                                   
|                                                                       
| I am currently running 5 Asus CUV4X-D based SMP boxes all with apic   
| _on_, amongst  which are squids, sql servers, workstation type setups 
| (2 my very own).                                                      

Do they have *sustained* heavy hit/IRQ/IO load?  For example, sending
25Mbit and >1,000 connections/s of sustained small images traffic
through khttpd will kill 2.4 (slow loss of timer and eventual total
freeze) in a couple of hours.  Trivially reproducable for me on SMP with
any amount of memory.  On HP, Tyan, Intel, Asus... etc.

| Have you run _yourself_ into a problem with 2.4.17?                   
| I mean it is not perfect of course, but it is far better than you make
| it look.                                                              

2.4.17 (and -pre/-rc) is my yardstick, actually.  With the exception of
-aa, I stay very close to the bleeding edge.

Please don't misunderstand -- I don't think any 2.4 kernel sucks (with
the exception of the two or three DONTUSE kernels. :)  In fact, I have
zero complaints other than the ones I've listed.  I was ecstatic when
2.2 came out, and 2.4 is just as impressive.

It's not that the kernel is bad, it's that there are specific things
that shouldn't be forgotten because of a "the kernel is good"
evaluation.  Especially those that make Linux regularly unstable in
common production environments.

| I could hand the brown bag to all versions below about 2.4.15  pretty 
| easy, but since 2.4.16 it has really become hard to shoot it down for 
| me. Ok, I use only pretty selected hardware, but there are reasons I  
| do, and they are not related to the kernel in first place.            

I use pretty selected hardware as well -- scaling hundreds of servers
for varied uses really depends on having someone track and select
hardware, and using it homogenously.  Of course, of all of the selected
hardware I've used over the last two years since 2.4.0-test1, C) has
persisted on all configurations, but the others are more recent but
equally omnipresent.

Like I said, I suspect that most people with machines in lower-load
environments don't have these issues, but "number of people effected" is
only one metric to judge the importance of an issue.

Of course, I'm not biased or anything. ;-)

Thanks for the input,
-- 
Ken.
brownfld@irridia.com


|                                                                       
| Regards,                                                              
| Stephan                                                               
|                                                                       
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
