Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154230AbPKKMU4>; Thu, 11 Nov 1999 07:20:56 -0500
Received: by vger.rutgers.edu id <S153912AbPKKMUu>; Thu, 11 Nov 1999 07:20:50 -0500
Received: from dukat.scot.redhat.com ([195.89.149.246]:1321 "EHLO dukat.scot.redhat.com") by vger.rutgers.edu with ESMTP id <S154224AbPKKMUE>; Thu, 11 Nov 1999 07:20:04 -0500
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14378.46183.729723.903734@dukat.scot.redhat.com>
Date: Thu, 11 Nov 1999 12:19:51 +0000 (GMT)
To: yodaiken@chelm.cs.nmt.edu
Cc: Roman Zippel <zippel@fh-brandenburg.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>, Jes.Sorensen@cern.ch, linux-kernel@vger.rutgers.edu, Stephen Tweedie <sct@redhat.com>
Subject: Re: linux interrupt handling problem
In-Reply-To: <19991110085430.A3482@chelm.cs.nmt.edu>
References: <E11lGba-0005EE-00@the-village.bc.nu> <Pine.GSO.4.10.9911101123510.2832-100000@zeus.fh-brandenburg.de> <19991110085430.A3482@chelm.cs.nmt.edu>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

On Wed, 10 Nov 1999 08:54:30 -0700, yodaiken@chelm.cs.nmt.edu said:

> On Wed, Nov 10, 1999 at 11:30:53AM +0100, Roman Zippel wrote:
>> That's a problem I would like to address later, since it's a perfomance
>> only problem, where the sti() stuff is also a portability problem.

> Any measurements to show that this is a real problem? My intuition
> is that the simple Linux model has enormous advantages over
> more complex schemes. 

There was a Usenix paper a couple of years ago:

    http://www.usenix.org/publications/library/proceedings/ana97/small.html

at which they did an evaluation of the normal splx() mechanism in NetBSD
with a simplified, Linux-like mechanism.  The simpler one won
hands-down.  They did note that spl made sense on older machines where
interrupt routines were, relatively, much longer due to the slower clock
speeds, but concluded that it didn't make sense on modern, fast CPUs.

Their proposal in the end is to protect kernel critical sections with
cli/sti, but to keep interrupts enabled during IRQs and rely on the PIC
to keep the interrupt line disabled during the ISR.  Odd, that looks
familiar, doesn't it?  :-)

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
