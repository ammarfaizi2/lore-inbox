Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbTAOOOB>; Wed, 15 Jan 2003 09:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbTAOOMj>; Wed, 15 Jan 2003 09:12:39 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:26588 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266453AbTAOOMb>;
	Wed, 15 Jan 2003 09:12:31 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15909.28249.617353.381378@harpo.it.uu.se>
Date: Wed, 15 Jan 2003 15:21:13 +0100
To: Ross Biro <rossb@google.com>
Cc: alan@lxorguk.ukuu.org.uk, andre@linux-ide.org, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: [2.4.21-pre3] Fix for Promise PIO Lockup
In-Reply-To: <3E2368CF.6050608@google.com>
References: <3E2368CF.6050608@google.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro writes:
 > Newer kernels will lock up when a drive command (SMART, hdparm -I, etc.) 
 > is issued to a drive connected to a Promise 20265 or 20267 controller 
 > while the controller is in DMA mode.  The problem appears to be that 
 > tune_chipset incorrectly clears the high PIO bit thinking that it is a 
 > "PIO force on" bit.  The documentation I have access to does not seem to 
 > mention a PIO force bit.  Not changing that bit seems to fix the problem 
 > with drive commands on a promise controller.
 > 
 > The documentation I have also says the values for the TB and TC 
 > variables should be the same for all UDMA modes and they are not. 
 >  However the driver seems to work anyway, so I left them the way they are.
 > 
 > To reproduce this problem make sure your drive is set to a DMA mode, eg 
 > hdparm -X 67 and then issue a drive command, e.g. hdparm -I.

I have tried to reproduce this problem according to your description
above, but neither my 20269 (with "new" driver) nor my 20267 (with
"old" driver) hangs. I checked with kernels 2.5.58 and 2.4.21-pre3.

Maybe something else is needed for the hang to occur?

/Mikael
