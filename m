Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVEMVvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVEMVvY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVEMVvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:51:24 -0400
Received: from mail.toyon.com ([65.160.147.241]:41829 "EHLO mail.toyon.com")
	by vger.kernel.org with ESMTP id S262535AbVEMVvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:51:00 -0400
Message-ID: <01cd01c55805$df437cf0$1600a8c0@toyon.corp>
From: "Peter J. Stieber" <developer@toyon.com>
To: <linux-kernel@vger.kernel.org>
References: <20050419133509.GF7715@wotan.suse.de> <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com> <20050502170042.GJ7342@wotan.suse.de> <1115047729.19314.1.camel@jasmine> <1115717814.7679.2.camel@jasmine> <20050510163851.GA1128@redhat.com> <20050510164649.GL25612@wotan.suse.de> <20050510165938.GA11835@redhat.com> <20050512212319.GE15965@wotan.suse.de>
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Date: Fri, 13 May 2005 14:51:09 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CW = Christopher Warner
CW>>>>> 2.6.11.5 kernel,
CW>>>>> Tyan S2882/dual AMD 246 opterons
CW>>>>> sh:18983: mm/memory.c:99: bad pmd
ffff810005974cc8(00007ffffffffe46).
CW>>>>> sh:18983: mm/memory.c:99: bad pmd
ffff810005974cd0(00007ffffffffe47).

DJ = Dave Jones
DJ>>>> That's the 3rd or 4th time I've seen this
DJ>>>> reported on this hardware.
DJ>>>> It's not exclusive to it, but it does seem more
DJ>>>> susceptible for some reason. Spooky.

AK = Andi Kleen wrote:
AK>>> It seems to be clear now that it is hardware
AK>>> independent.
AK>>>
AK>>> I actually got it once now too, but only after
AK>>> 24+h stress test :/
AK>>>
AK>>> I have a better debugging patch now that I will be
AK>>> testing soon, hopefully that turns something up.

DJ = Dave Jones
DJ>> Ok, I'm respinning the Fedora update kernel today
DJ>> for other reasons, if you have that patch in time,
DJ>> I'll toss it in too.
DJ>>
DJ>> Though as yet, no further reports from our users.

AK = Andi Kleen
AK> Here's the new patch. However it costs some memory
AK> bloat because I added a new field to struct page

I posted some information on the fedora-list concerning my experience
with this problem. I am using a Tyan S2885/dual 244 Opterons. For HW and
driver details see:
https://www.redhat.com/archives/fedora-list/2005-May/msg01690.html

I have been using Dave's FC3 test kernel (2.6.11-1.24_FC3smp) for a
little over a day and have been unable to generate the problem with the
computer under a larger than normal load.

Prior to May 12, I had been seeing the problem very regularly. It
started around April 14. I believe this is about the time I first
started using the 2.6.11-1.14_FC3smp kernel. I remember I had to get a
BIOS upgrade from Tyan (http://www.tyan.com/support/html/b_s2885.html
unfortunately a Beta release) to get my network back once I started
using the new kernel. After that the memory.c messages started showing
up. I though it might be BIOS related (see the note on the referenced
Tyan page), but when I saw Christopher's post I thought maybe it was the
kernel because his MOBO doesn't have a Beta BIOS release. I googled and
found this thread, and subscribed to this list.

I have "memory.c:97 bad pmd" entries in my /var/log/messages files going
back to April 14. The only days I don't have them are April 20, 22, 23,
24 and April 29 (22, 23, and 24 are a weekend with less activity). I
have had them every day in May until I installed Dave's test kernel.

I am very computer literate, but not a kernel developer. I hope I didn't
offend you guys by posting here. I would be willing to be your guinea
pig for testing. Currently I am unable to reproduce the problem. If I am
able to reproduce the problem, would you prefer I post here or on the
fedora list?

Thanks for all of your efforts,
Pete


