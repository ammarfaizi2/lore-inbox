Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272882AbRJJUtp>; Wed, 10 Oct 2001 16:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274530AbRJJUtf>; Wed, 10 Oct 2001 16:49:35 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5522 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S272882AbRJJUtX>;
	Wed, 10 Oct 2001 16:49:23 -0400
Date: Wed, 10 Oct 2001 13:46:34 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Paul Larson <plars@austin.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11 APIC problems
Message-ID: <1994214429.1002721594@mbligh.des.sequent.com>
In-Reply-To: <1002727820.29151.21.camel@plars.austin.ibm.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  So, I tried inserting the die() like you said without console serial.  I
>  got pagefulls of dumps and pretty soon it rebooted itself.  So, I logged
>  to the serial console again on the next reboot to capture the output. 
>  Looks like we got the "APIC error" message in the log too.  It's a
>  really long log so I attached it rather than putting it inline.

Ick. You need to disable the repeated interrupt. Try this instead of
the die:

cli();
 __asm__ __volatile__ ("hlt");

And if it makes a huge logfile again, just mail the first bit .... I don't
care about huge emails, but others on lkml probably do ;-)

M.

PS. Nor do I care what the die says, I just want to stop the processor.
I want to know what it was doing just before the smp_error_interrupt.
There are more elegant solutions around to stop repeated APIC errors,
but this should be OK for debug.
