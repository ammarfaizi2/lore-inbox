Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVENR3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVENR3h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVENR3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:29:33 -0400
Received: from mail.toyon.com ([65.160.147.241]:18632 "EHLO mail.toyon.com")
	by vger.kernel.org with ESMTP id S262808AbVENR3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:29:13 -0400
Message-ID: <00bb01c558aa$75bb2210$1600a8c0@toyon.corp>
From: "Peter J. Stieber" <developer@toyon.com>
To: <linux-kernel@vger.kernel.org>
References: <20050419133509.GF7715@wotan.suse.de> <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com> <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com> <20050502170042.GJ7342@wotan.suse.de> <1115047729.19314.1.camel@jasmine> <1115717814.7679.2.camel@jasmine> <20050510163851.GA1128@redhat.com> <20050510164649.GL25612@wotan.suse.de> <20050510165938.GA11835@redhat.com> <20050512212319.GE15965@wotan.suse.de> <01cd01c55805$df437cf0$1600a8c0@toyon.corp>
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
Date: Sat, 14 May 2005 10:29:19 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CW = Christopher Warner
CW>>>>>> 2.6.11.5 kernel,
CW>>>>>> Tyan S2882/dual AMD 246 opterons
CW>>>>>> sh:18983: mm/memory.c:99: bad pmd
CW>>>>>> ffff810005974cc8(00007ffffffffe46).
CW>>>>>> sh:18983: mm/memory.c:99: bad pmd
CW>>>>>> ffff810005974cd0(00007ffffffffe47).

DJ = Dave Jones
DJ>>>>> That's the 3rd or 4th time I've seen this
DJ>>>>> reported on this hardware.
DJ>>>>> It's not exclusive to it, but it does seem more
DJ>>>>> susceptible for some reason. Spooky.

AK = Andi Kleen wrote:
AK>>>> It seems to be clear now that it is hardware
AK>>>> independent.
AK>>>>
AK>>>> I actually got it once now too, but only after
AK>>>> 24+h stress test :/
AK>>>>
AK>>>> I have a better debugging patch now that I will be
AK>>>> testing soon, hopefully that turns something up.

DJ = Dave Jones
DJ>>> Ok, I'm respinning the Fedora update kernel today
DJ>>> for other reasons, if you have that patch in time,
DJ>>> I'll toss it in too.
DJ>>>
DJ>>> Though as yet, no further reports from our users.

PJS = Peter J. Stieber
PJS> I posted some information on the fedora-list
PJS> concerning my experience with this problem. I
PJS> am using a Tyan S2885/dual 244 Opterons. For HW and
PJS> driver details see:
PJS> https://www.redhat.com/archives/fedora-list/2005-May/msg01690.html
PJS> I have been using Dave's FC3 test kernel
PJS> (2.6.11-1.24_FC3smp) for a little over a day and
PJS> have been unable to generate the problem with the
PJS> computer under a larger than normal load.
PJS>
PJS> Prior to May 12, I had been seeing the problem very
PJS> regularly. It started around April 14. I believe this
PJS> is about the time I first started using the
PJS> 2.6.11-1.14_FC3smp kernel. I remember I had to get a
PJS> BIOS upgrade from Tyan
PJS> (http://www.tyan.com/support/html/b_s2885.html
PJS> unfortunately a Beta release) to get my network back
PJS> once I started using the new kernel. After that the
PJS> memory.c messages started showing up. I though it
PJS> might be BIOS related (see the note on the referenced
PJS> Tyan page), but when I saw Christopher's post I
PJS> thought maybe it was the kernel because his MOBO
PJS> doesn't have a Beta BIOS release. I googled and
PJS> found this thread, and subscribed to this list.
PJS>
PJS> I have "memory.c:97 bad pmd" entries in my
PJS> /var/log/messages files going back to April 14.
PJS> The only days I don't have them are April 20, 22, 23,
PJS> 24 and April 29 (22, 23, and 24 are a weekend with
PJS> less activity). I have had them every day in May
PJS> until I installed Dave's test kernel.
PJS>
PJS> I am very computer literate, but not a kernel
PJS> developer. I hope I didn't offend you guys by
PJS> posting here. I would be willing to be your guinea
PJS> pig for testing. Currently I am unable to reproduce
PJS> the problem. If I am able to reproduce the problem,
PJS> would you prefer I post here or on the
PJS> fedora list?
PJS>
PJS> Thanks for all of your efforts,

My Tyan S2885 just exhibited the problem with Dave's test FC3 kernel
(2.6.11-1.24_FC3smp):

May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d008(0000000000000008).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d018(0000000000000009).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d020(0000000000401b80).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d028(000000000000000b).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d030(00000000000001f4).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d038(000000000000000c).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d040(00000000000001f4).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d048(000000000000000d).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d050(00000000000001f7).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d058(000000000000000e).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d060(00000000000001f7).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d068(0000000000000017).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d078(000000000000000f).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d080(00007ffffffff0a4).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d0a0(5f36387800000000).
May 14 10:00:18 maggie kernel: collect2:14167: mm/memory.c:98: bad pmd
ffff81005856d0a8(0000000000003436).

It died while running configure. It was attempting to use gcc to make
sure C compiling was possible. In the past, if I run the script a second
time it works.

Sorry for my ignorance, but what other information do you need?
Pete 


