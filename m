Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRDJMew>; Tue, 10 Apr 2001 08:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131666AbRDJMeo>; Tue, 10 Apr 2001 08:34:44 -0400
Received: from iris.mc.com ([192.233.16.119]:44237 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131638AbRDJMed>;
	Tue, 10 Apr 2001 08:34:33 -0400
From: Mark Salisbury <mbs@mc.com>
To: David Schleef <ds@schleef.org>, David Schleef <ds@schleef.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No 100 HZ timer !
Date: Tue, 10 Apr 2001 08:19:59 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010410002852.4212A-100000@artax.karlin.mff.cuni.cz> <E14mkGA-000341-00@the-village.bc.nu> <20010410044336.A1934@stm.lbl.gov>
In-Reply-To: <20010410044336.A1934@stm.lbl.gov>
MIME-Version: 1.0
Message-Id: <0104100825201B.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, David Schleef wrote:
> i.e., the TSC, you have to use 8254 timer 0 as both the timebase
> and the interval counter -- you end up slowly losing time because
> of the race condition between reading the timer and writing a
> new interval.  

actually, I have an algorithm to fix that.  (had to implement this on a system
with a single 32 bit decrementer (an ADI21060 SHARC, YUK!))  the algorithm
simulates a free spinning 64 bit incrementer given  a 32 bit interrupting
decrementer under exclusive control of the timekeeping code.  it also takes
into account the read/calculate/write interval.


  
> It would be nice to see any redesign in this area make it more
> modular.  I have hardware that would make it possible to slave
> the Linux system clock directly off a high-accuracy timebase,
> which would be super-useful for some applications.  I've been
> doing some of this already, both as a kernel patch and as part
> of RTAI; search for 'timekeeper' in the LKML archives if interested.
> 
> 
> 
> 
> dave...
-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

