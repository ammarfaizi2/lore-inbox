Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTBKTVl>; Tue, 11 Feb 2003 14:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTBKTVl>; Tue, 11 Feb 2003 14:21:41 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:18071 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264938AbTBKTVl>;
	Tue, 11 Feb 2003 14:21:41 -0500
Date: Tue, 11 Feb 2003 20:31:27 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Henrik Persson <nix@socialism.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via rhine bug? (timeouts and resets)
Message-ID: <20030211193126.GA3136@k3.hellgate.ch>
Mail-Followup-To: Henrik Persson <nix@socialism.nu>,
	linux-kernel@vger.kernel.org
References: <200302111344.h1BDiMPY067070@sirius.nix.badanka.com> <20030211154449.GA2252@k3.hellgate.ch> <200302111652.h1BGq0PY067795@sirius.nix.badanka.com> <20030211171736.GA1359@k3.hellgate.ch> <200302111745.h1BHjdPY067992@sirius.nix.badanka.com> <20030211183943.GA2443@k3.hellgate.ch> <200302111855.h1BItiPY068299@sirius.nix.badanka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302111855.h1BItiPY068299@sirius.nix.badanka.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.60 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2003 19:55:07 +0100, Henrik Persson wrote:
> Something was strange.. Now I get the errors.. But the funny thing is:
> when downloading the file there's no problem at all. Uploading the same

It's the Rhine Tx engine that's been giving us headaches all along. There's
at least one bug in the Rx path, too, but it's masked by the Tx problems.

Try this, log again. This will show whether I'm suspecting the right bug.

@@ -1290,6 +1290,9 @@ static void via_rhine_interrupt(int irq,
 	while ((intr_status = readw(ioaddr + IntrStatus))) {
 		/* Acknowledge all of the current interrupt sources ASAP. */
 		writew(intr_status & 0xffff, ioaddr + IntrStatus);
+		if (readb(ioaddr+0x84) & 0x08)
+			printk(KERN_DEBUG "Gotcha: %#x %#x %#x\n", intr_status,
+				readb(ioaddr+0x84), readb(ioaddr+0x86));
 
 		if (debug > 4)
 			printk(KERN_DEBUG "%s: Interrupt, status %4.4x.\n",

Roger
