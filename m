Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbTCHAAd>; Fri, 7 Mar 2003 19:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261930AbTCHAAd>; Fri, 7 Mar 2003 19:00:33 -0500
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:12555 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261929AbTCGX7f>; Fri, 7 Mar 2003 18:59:35 -0500
Date: Sat, 8 Mar 2003 01:10:05 +0100
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports
Message-ID: <20030308001005.GA20120@alf.amelek.gda.pl>
References: <3E692281.10906@jpl.nasa.gov> <3E692B1C.5010607@jpl.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E692B1C.5010607@jpl.nasa.gov>
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:28:28PM -0800, Bryan Whitehead wrote:
> I just found this:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0212.2/0845.html
> 
> Has this patch been accepted into the new kernel series? Or should I 
> just toss this card (the NetMos PCI I/O card)?

No, and no.  Try these patches (apply in this order, may need
some hand-patching to apply to the current 2.4.21-pre source):

http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/00_parport_serial
http://www.amelek.gda.pl/linux-patches/2.4.20-pre9/01_netmos

Please test - I'd like to know if it works for you.  It should -
I have 3 such cards in 2 servers, running patched 2.4.20 kernel
in production use for 3 months now (mainly serial ports used, but
2S1P cards were cheaper than 2S cards...).  Attempts to submit
the changes have been ignored, so I gave up...

NetMos support was already in early 2.4.x kernels, later removed:

	* parport_serial.c: Remove NetMos support, since it causes problems
	for some people.

No idea what exactly these problems are, who "some people" are, why
NetMos support was not simply made a config option conditional on
CONFIG_EXPERIMENTAL, and why the link order bugfix (separate patch,
which only fixes an obvious bug) has been ignored too.

Perhaps you will have more luck than I did - test your card with the
patches for some time, if it works try to submit the patches again...

> >I hoped after "setting up" the serial ports with setserial some magic 
> >would happen and they would apear in /dev/tts... but I was wrong.

I don't use devfs, so I never had this problem.

Hope this helps,
Marek

