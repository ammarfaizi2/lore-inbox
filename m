Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135784AbRDTCrX>; Thu, 19 Apr 2001 22:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135785AbRDTCrO>; Thu, 19 Apr 2001 22:47:14 -0400
Received: from smtp3.xs4all.nl ([194.109.127.132]:38917 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S135784AbRDTCqz>;
	Thu, 19 Apr 2001 22:46:55 -0400
Path: Home.Lunix!not-for-mail
Subject: Re: IP Acounting Idea for 2.5
Date: Fri, 20 Apr 2001 02:51:55 +0000 (UTC)
Organization: lunix confusion services
In-Reply-To: <E14pfQ3-0003bG-00@the-village.bc.nu>
NNTP-Posting-Host: kali.eth
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 987735115 26949 10.253.0.3 (20 Apr 2001
    02:51:55 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Fri, 20 Apr 2001 02:51:55 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:85998
X-Mailer: Perl5 Mail::Internet v1.32
Message-Id: <9bo88b$qa5$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14pfQ3-0003bG-00@the-village.bc.nu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> > No he isnt confused, you are trying to dictate policy.
>> 
>> What then *is* the policy?
> 
> The policy is not to have policy. It works as well in kernel design as politics.
> 
> Alan
> 
Since my job is in fact mainly this kind of apps, i really feel strongly
about this. 

Resettable counters are evil.

Having resettable counters may not sound like it, but it is in fact policy.
It forces all apps to add code to detect these resets (and then give 
warnings/errors, since there is just no way to do anything sensible with
them), since ignoring them will seemingly cause up to 2**32 counts suddenly.

It is also doing something in kernelspace which can be done in userspace,
which is normally considered a big nono.

Proposal: have a snapshot command, that remembers the current value of a
counter. Then have two interfaces: one that shows the continuous counter
and one that shows the subtraction of the current value from the snapshot.
The first can be used by used by serious applications (don't have to
add code to give warnings about dataloss), and the second can be used by 
users who want to watch the counters a bit to get a feel for what a rule
is doing.

I really think cisco got this right: from the commandline interface
you can reset counters, and watch them, the SNMP counters however just
keep going and going and going independently from this.

(I think this snapshotting belongs in the apps reading the counters
really, but if you really insist on a kernel based reset, this might be
reasonable).
