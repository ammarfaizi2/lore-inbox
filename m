Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271813AbRHRLiW>; Sat, 18 Aug 2001 07:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271815AbRHRLiN>; Sat, 18 Aug 2001 07:38:13 -0400
Received: from fungus.teststation.com ([212.32.186.211]:45831 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S271813AbRHRLiA>; Sat, 18 Aug 2001 07:38:00 -0400
Date: Sat, 18 Aug 2001 13:38:11 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Dennis Bjorklund <db@zigo.dhs.org>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: 2.2.19: d-link dfe530-tx, Transmit timed out
In-Reply-To: <Pine.LNX.4.33.0108181050550.27920-200000@cosmo.zigo.dhs.org>
Message-ID: <Pine.LNX.4.30.0108181305040.3563-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2001, Dennis Bjorklund wrote:

> The 2.4.x driver have some spinlocks that seems necessary for SMP but it
> looks like there are spinlocks missing already in the old 2.2.19 driver if
> one compares with the 2.4.x driver. I didn't fix any of these things since
> I don't understand all the issues. My feeling is that it is as good or bad
> now as before.

I don't understand all the issues either. 2.4 was changed to be more
multithreaded in the network code (above the drivers), aka softnet. The
via-rhine broke on SMP when this was introduced and the locks were then
added to prevent races between interrupt handler and xmit code.

The changes look fine to me.

> I have used it and loaded the network to trigger the bug, and every time
> where it froze before it works now and the card resets. For light load it
> worked before. To trigger the bug I let the computers on my network send
> constantly for an hour or two. Before it used to freeze efter 2-3 weeks of
> normal load so it's not easy to trigger.
...
> I can't prove that this fixes it but it sure looks like it. It prints the
> timout message in the log as before, but continues working.
> 
> The last question is what to do with the version string, and what to do to
> get this into 2.2.20 (if it's wanted).

Call it v1.08b-LK1.0.1 and send an updated patch vs the latest 2.2.20-pre
to Alan.

If you can get others to verify that it works, that strengthens your case.
But it sounds like you could reliably reproduce the problem, and
considering that (more or less) the same fix is in 2.4 for the same reason
...

The 2.4 tree has a SubmittingPatches text with some hints on how to not
annoy the recipient (not that there was anything wrong with this mail,
except that some people have attachment allergy :)

/Urban

