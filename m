Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262304AbSJJV7h>; Thu, 10 Oct 2002 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSJJV7h>; Thu, 10 Oct 2002 17:59:37 -0400
Received: from mario.gams.at ([194.42.96.10]:34388 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S262304AbSJJV7f> convert rfc822-to-8bit;
	Thu, 10 Oct 2002 17:59:35 -0400
Message-Id: <200210102205.g9AM5AK25232@frodo.gams.co.at>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.3
From: Bernd Petrovitsch <bernd@gams.at>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Netfilter-devel <netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.4.20pre8aa2 failed assertions in ip_{conntrack,nat}_core.c 
References: <1034283708.25146.25.camel@tux> 
In-reply-to: Your message of "10 Oct 2002 23:01:48 +0200."
             <1034283708.25146.25.camel@tux> 
X-url: http://www.luga.at/~bernd/
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Fri, 11 Oct 2002 00:05:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson <gandalf@wlug.westbo.se> wrote:
>> [2.] Full description of the problem/report:
>> I'm running 2.4.20pre8aa2 with all the firewalling stuff enabled 
>> on a Pentium 75 and get occasionally
>> ----  snip (lines broken to keep it readable) ----
>> Oct 10 20:00:04 fw kernel: ASSERT ip_conntrack_core.c:97
>>                              &ip_conntrack_lock readlocked 
>> Oct 10 20:00:04 fw kernel: ASSERT ip_conntrack_core.c:1067
>>                              &ip_conntrack_lock not readlocked 
>> Oct 10 20:00:04 fw kernel: ASSERT: ip_nat_core.c:841
>>                              &ip_conntrack_lock not readlocked 
>> Oct 10 20:00:04 fw kernel: ASSERT ip_conntrack_core.c:97
>>                              &ip_conntrack_lock readlocked 
>> Oct 10 20:00:04 fw kernel: ASSERT: ip_nat_core.c:841
>>                              &ip_conntrack_lock not readlocked 
>> ----  snip  ----
>> Otherwise everything is working fine.
>
>I've attached a small patch that fixes the ip_conntrack_core.c:97 and
>ip_nat_core.c:841 messages, These two messages aren't bugs in the
>locking, it's just the lock-debugging that can't handle "recursive"
>read-locks on the same lock and cpu correctly and thus reports an error
>even though everything is fine.

This explains why the box was actually usable.

>(the patch is made against 2.4.20-pre8-ac2 but it should apply.)

It does. Compiled and boot4ed the patched kernel.

>ASSERT ip_conntrack_core.c:1067 &ip_conntrack_lock not readlocked
>this might be a real locking-bug but it's only used in
>conntrack-handlers so unless you have two expectations happening at the
>same time on diffrent cpu's there's no problem. I'll look into it.

Thanks!

>> [6.] A small shell script or example program which triggers the
>>      problem (if possible)
>> Simply http'ing or ftp'ing trigger it occasionally. The symptom is 
>> that a particular (TCP-)connection "freezes".
>
>hmm, shouldn't happen. Can you describe it in more detail?

Not really, it just popped up a dozen times within 3 hours within 7 
minutes (hmm, God knows what I was doing exactly at that time to 
trigger it).
And I actually realized it only because some <tab> completion in 
ncftp hang (of course it came out on the console but who is looking 
there all the time since that's not the primary PC).
I'll see if it occurs again .....

	Bernd
-- 
Bernd Petrovitsch                              Email : bernd@gams.at
g.a.m.s gmbh                                  Fax : +43 1 205255-900
Prinz-Eugen-Straﬂe 8                    A-1040 Vienna/Austria/Europe
                     LUGA : http://www.luga.at


