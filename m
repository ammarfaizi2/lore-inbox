Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132941AbRDERZ6>; Thu, 5 Apr 2001 13:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132944AbRDERZt>; Thu, 5 Apr 2001 13:25:49 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:1040 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132941AbRDERZg>; Thu, 5 Apr 2001 13:25:36 -0400
Message-Id: <200104051724.f35HOms47087@aslan.scsiguy.com>
To: Igor Mozetic <igor.mozetic@uni-mb.si>
cc: Eric Valette <valette@crf.canon.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 + aic7xxx-6.1.9 doesn't boot 
In-Reply-To: Your message of "Thu, 05 Apr 2001 15:19:28 +0200."
             <15052.28896.299341.145765@ravan.camtp.uni-mb.si> 
Date: Thu, 05 Apr 2001 11:24:48 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The latest aic7xxx-6.1.9 doesn't boot, I can see something like:
>
>scsi1:0:0:0: Attempting to queue an ABORT message 
>scsi1:0:0:0: Command found on device queue 
>aic7xxx_abort returns 8194 

Either disable the initial bus reset in SCSI-Select or lower
the bus settle delay from 15000ms to something like 5000ms
in your kernel config.  Because I enforce the bus settle
delay by blocking incoming commands from the SCSI layer, yet
the low level drivers are not responsible for timeout handling,
the top level starts timeing out probe requests with short timeouts.
The current strategy allows the system to finish inializing other
devices while the bus settle expires, but it has this vulnerability.

It is also my fault for not properly testing the default bus settle
delay.  The system I tested it on had initial bus resets disabled
from a prior test of that scenario.  Oops.

--
Justin
