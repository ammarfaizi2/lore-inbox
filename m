Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVJCOSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVJCOSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 10:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVJCOSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 10:18:24 -0400
Received: from smtp.innovsys.com ([66.115.232.196]:2689 "EHLO
	mail.innovsys.com") by vger.kernel.org with ESMTP id S932243AbVJCOSY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 10:18:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: clock skew on B/W G3
Date: Mon, 3 Oct 2005 09:18:14 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clock skew on B/W G3
thread-index: AcXHcNP+cpPD46M5R1C09vz0su3p1gAs4Hsg
From: "Rune Torgersen" <runet@innovsys.com>
To: "Marc" <marvin24@gmx.de>, <linuxppc-dev@ozlabs.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From:  Marc
> Sent: Sunday, October 02, 2005 11:46
> 
> Some additions to the previous mail: I was able to isolate 
> the problem to the 
> introduction of a user specificable value of HZ (in 
> include/asm-ppc/parm.h). 
> I used a value of 250 while the former default was 1000. 
> Setting it back to 
> 1000 makes the clock tick right again.
> 
> Is the CONFIG_HZ known to be broken on PPC ?
> 

CONFIG_HZ is not broken, but the whole clock configuration is.
(I poseded something about it for 8260 earlier this summer)

Basic problem is that CLOCK_TICK_RATE which is used for setting up the
variables used for advancing the clock, is hardcoded to a value that
only makes sence for an i386. (it is default set at 1193180Hz which
happens to be the timer clock for timer1 on an i386 machine)

Another problem here is that that value apparently hve to be #define'd
which means you cannot insert the decrementer frequency from the
boot-loader either.

