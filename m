Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314094AbSDQOmY>; Wed, 17 Apr 2002 10:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314095AbSDQOmX>; Wed, 17 Apr 2002 10:42:23 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:31749 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S314094AbSDQOmW>; Wed, 17 Apr 2002 10:42:22 -0400
Date: Wed, 17 Apr 2002 08:41:41 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.44.0204162244420.9280-100000@skuld.mtroyal.ab.ca>
To: linux-kernel@vger.kernel.org
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Jeff Nguyen <jeff@aslab.com>,
        Ingo Molnar <mingo@elte.hu>
Message-id: <Pine.LNX.4.44.0204170808160.17511-100000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,
After Ingo forwarded me his original patch (I found his patch via a web
based medium, which had converted all of the left shifts to compares, and
now I'm very glad it didn't boot...) and the system is booted and is
balancing most of the interrupts at least.  Here's the current output
of /proc/interrupts

brynhild:bash$ cat /proc/interrupts 
           CPU0       CPU1       
  0:     171414          0    IO-APIC-edge  timer
  1:          3          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 18:          8          7   IO-APIC-level  aic7xxx
 19:      13566      12799   IO-APIC-level  eth0
 20:          9          7   IO-APIC-level  aic7xxx
 21:          9          7   IO-APIC-level  aic7xxx
 27:       1572       5371   IO-APIC-level  megaraid
NMI:          0          0 
LOC:     171315     171251 
ERR:          0
MIS:          0

So, the timer isn't being balanced still, others are (is there a
specific case in your patch for irq 0 (< 1)?  I couldn't see it but
it almost looks as though it's being missed..)

Thanks to all that replied.

Regards
James 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


