Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWJHGnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWJHGnU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 02:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWJHGnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 02:43:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27868 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750792AbWJHGnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 02:43:19 -0400
Date: Sun, 8 Oct 2006 08:43:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, Alex Romosan <romosan@sycorax.lbl.gov>,
       linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, linux-pm@osdl.org
Subject: Re: 2.6.19-rc1 regression: airo suspend fails
Message-ID: <20061008064303.GA3111@elf.ucw.cz>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <871wpmoyjv.fsf@sycorax.lbl.gov> <20061006184706.GR16812@stusta.de> <1160250771.24902.6.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160250771.24902.6.camel@kleikamp.austin.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > it breaks suspend when the airo module is loaded:
> > > 
> > > kernel: Stopping tasks: =================================================================================
> > > kernel:  stopping tasks timed out after 20 seconds (1 tasks remaining):
> > > kernel:   eth1
> > > kernel: Restarting tasks...<6> Strange, eth1 not stopped
> > > 
> > > if i remove the airo module suspend works normally (this is on a
> > > thinkpad t40).
> > 
> > Thanks for your report.
> > 
> > Let's try to figure out what broke it.
> 
> I believe it was broken by:
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=3b4c7d640376dbccfe80fc4f7b8772ecc7de28c5
> 
> I have seen this in the -mm tree, but didn't follow up at the time.  I
> was able to fix it with the following patch.  I don't know if it's the
> best fix, but it seems to follow the same logic as the original code.
> 
> 
> The airo driver used to break out of while loop if there were any signals
> pending.  Since it no longer checks for signals, it at least needs to check
> if it needs to be frozen.
> 
> Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

ACK. Please push it to akpm or airo maintainers...

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
