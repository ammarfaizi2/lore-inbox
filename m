Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292752AbSCKUXv>; Mon, 11 Mar 2002 15:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSCKUXm>; Mon, 11 Mar 2002 15:23:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:764 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292752AbSCKUXb>;
	Mon, 11 Mar 2002 15:23:31 -0500
Importance: Normal
Sensitivity: 
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal instructions"
To: "Tom Epperly" <tepperly@llnl.gov>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OF74E7C6B7.70CA5551-ON88256B79.00670A00@boulder.ibm.com>
From: "James Washer" <washer@us.ibm.com>
Date: Mon, 11 Mar 2002 12:26:14 -0800
X-MIMETrack: Serialize by Router on D03NM038/03/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/11/2002 01:23:27 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

If I send you a patch to do a bit of debugging, would you be able to run
it? Basically, my plan is just to call a die() like routine for  trap=6, so
that we get a good stack frame (much like an oops).. From there, we should
be able to figure out WHY the program is getting an illegal op..

My guesses at this point in time are....  bad file io( i.e. the executable
is corrupt) , or bad mem... (check to see if the same phys page is being
used, for example)

 - jim

"Tom Epperly" <tepperly@llnl.gov>@vger.kernel.org on 03/11/2002 08:07:05 AM

Sent by:    linux-kernel-owner@vger.kernel.org


To:    Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:    linux-kernel@vger.kernel.org
Subject:    Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal
       instructions"



Alan Cox wrote:

>>Do you agree that this is likely to be a kernel problem?  Is upgrading
>>the kernel my best course of action?
>>
>
>Almost every other report I have ever seen that looked like that one has
always
>turned out to be hardware related. The randomness in paticular tends to be
>a pointer to thinks like cache faults.
>
>You do have ECC main memory which is good.
>
>What other hardware is in the machine ?
>
>
To recap from an earlier email, my nightly build & regression tests (a
roughly 2 hour process involving Sun's JDK, GNU make, gcc, g++, g77 &
Bourne shell scripts) has been failing intermittently on a dual-Xeon
system usually with an "Illegal intruction" signal. I've tried removing
the sound card and disabling the X11 server to avoid loading the nVidia
kernel mod. The intermittent failures disappear when I run non-SMP. I've
tried swapping the processors on the motherboard, and both processors
appear to work fine individually. Most of the boxes I've run on have >=
512MB ECC RAM. I've run Dell's hardware diagnostics (especially the
memory ones) twice. The diagnostics don't seem to have SMP tests where
both CPUs are being stressed.

FYI when I upgraded to the 2.4.18-1smp kernel, the failure rate went
from 20% to 100%. I have tried running the nightly build & regression on
roughly 6 different dual processors Pentium III or better machines
(cylcing it over and over), and they all have intermittent failures of
one kind or another. All these machines are made by Dell, but they
provide some evidence that it is not a hardware problem.

Tom

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



