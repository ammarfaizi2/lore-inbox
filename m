Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbRCGQGT>; Wed, 7 Mar 2001 11:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131092AbRCGQGK>; Wed, 7 Mar 2001 11:06:10 -0500
Received: from colorfullife.com ([216.156.138.34]:46091 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131076AbRCGQGF>;
	Wed, 7 Mar 2001 11:06:05 -0500
Message-ID: <001501c0a720$76782030$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrea Barisani" <lcars@infis.univ.trieste.it>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10103071458560.9169-100000@sole.infis.univ.trieste.it>
Subject: Re: Kernel 2.4.2 command execution hangs and then succeded after 2  minutes....!? STRACE-DUMP
Date: Wed, 7 Mar 2001 17:04:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Andrea Barisani" <lcars@infis.univ.trieste.it>
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, March 07, 2001 3:03 PM
Subject: Re: Kernel 2.4.2 command execution hangs and then succeded
after 2 minutes....!? STRACE-DUMP


> On Wed, 7 Mar 2001, Manfred Spraul wrote:
>
> > Could you use strace and check what the apps are doing during these
2
> > minutes?
> >
> > Perhaps it's a variation of the nis hang:
> > 2.4 doesn't forword udp error messages to the user space app, and
thus a
> > nis query to a nonexistant nis server blocks until the udp packets
time
> > out.
> >
>
> Here are the three traces (mc,pine,tar)
> The system hangs for minutes in the last part, before the interrupt
> Sorry for the size of this email...:)

I got a new DSL connection last week, and right now I have a flat rate
:-)

> sendto(5,
";\255Cn\0\0\0\0\0\0\0\2\0\1\206\240\0\0\0\2\0\0\0\3\0\0"..., 56, 0,
{sin_family=AF_INET, sin_port=htons(111),
sin_addr=inet_addr("127.0.0.1")}}, 16) = 56
That's the problem:
NIS is configured and tries to connect to the NIS server on localhost.
It uses portmap to locate the server, but portmap is not running.
2.2 just forwarded the error message to the application, but 2.4
silently ignores the error message because these error messages caused
spurious application faults.

Check your nis configuration (afaik /etc/nsswitch.conf)

--
    Manfred


