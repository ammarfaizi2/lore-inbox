Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268992AbUI2U2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268992AbUI2U2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269007AbUI2U2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:28:10 -0400
Received: from bender.bawue.de ([193.7.176.20]:28909 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S268992AbUI2U15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:27:57 -0400
Date: Wed, 29 Sep 2004 22:27:50 +0200
From: Joerg Sommrey <jo175@sommrey.de>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: nmi watchdog failure on dual Athlon box
Message-ID: <20040929202750.GA5534@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040928163324.GA5759@sommrey.de> <Pine.LNX.4.58L.0409281802270.32231@blysk.ds.pg.gda.pl> <20040928183103.GA10593@sommrey.de> <Pine.LNX.4.58L.0409282159480.24587@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0409282159480.24587@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 10:08:21PM +0100, Maciej W. Rozycki wrote:
> On Tue, 28 Sep 2004, Joerg Sommrey wrote:
> 
> > |--- lockupcli.c
> > |
> > |main ()
> > |{
> > |	iopl(3);
> > |	for (;;) asm("cli");
> > |}
> > 
> > Does this mean there is a good reason for further investigations on why
> > the IO-APIC NMI watchdog doesn't work? Until now I thought it would
> > be ok as long as the local APIC NMI watchdog is set up.
> 
>  Since this program does busy looping, the local APIC NMI watchdog should
> trigger indeed.  It's "cli; hlt" that causes a problem with this watchdog.  
> Something wrong is happening in your system, indeed.

As I stated earlier, there *seemed* to be a working IO-APIC NMI watchdog
with 2.6.3-mm4.  I never checked it's functionallity. Now I rebuilt that
kernel and gave it a try.  Though it claims to have a running IO-APIC NMI
watchdog, the lockupcli test failed.  Zwane was right when he suspected the
nmi_watchdog=1 test working erratically in that case.  Sad but true: no NMI
watchdog on tyan S2466.  I wonder if it's just impossible on such a board
or if it needs some "special treatment" 

-jo

-- 
-rw-r--r--  1 jo users 63 2004-09-29 22:10 /home/jo/.signature
