Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbTBTKCf>; Thu, 20 Feb 2003 05:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbTBTKCf>; Thu, 20 Feb 2003 05:02:35 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:4536 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id <S265097AbTBTKCd>;
	Thu, 20 Feb 2003 05:02:33 -0500
Message-ID: <006301c2d8c8$921c1d10$760010ac@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Andi Kleen" <ak@suse.de>, "Simon Kirby" <sim@netnation.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>, <davem@redhat.com>
References: <20030219174757.GA5373@netnation.com.suse.lists.linux.kernel> <p73r8a3xub5.fsf@amdsimf.suse.de> <20030220092043.GA25527@netnation.com> <20030220093422.GA16369@wotan.suse.de>
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Date: Thu, 20 Feb 2003 11:12:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Feb 20, 2003 at 01:20:43AM -0800, Simon Kirby wrote:
> > On Thu, Feb 20, 2003 at 08:52:46AM +0100, Andi Kleen wrote:
> >
> > > That's probably because of the lazy ICMP socket locking used for the
> > > ICMP socket. When an ICMP is already in process the next ICMP
triggered
> > > from a softirq (e.g. ECHO-REQUEST) is dropped
> > > (see net/ipv4/icmp_xmit_lock_bh())
> >
> > Hmm...and this is considered desired behavior?  It seems like an odd way
> > of handling packets intended to test latency and reliability. :)
>
> IP is best-effort. Dropping packets in odd cases to make locking simpler
> is not unreasonable. Would you prefer an slower kernel?

Yes IP is best-effort. But this argument cant explain why IP on linux works
better if we disable SMP on linux...

I'm sorry Andy but "IP is best effort" sounds very lazy in this case.

SMP should give more power to the machine, not drop some frames because
'another CPU' is busy and has a lock we *need*.

Eric

