Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWBUVAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWBUVAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWBUVAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:00:05 -0500
Received: from ns.suse.de ([195.135.220.2]:53933 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932766AbWBUVAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:00:02 -0500
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: softlockup interaction with slow consoles
Date: Tue, 21 Feb 2006 21:43:46 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
References: <p73mzgk4y9u.fsf@verdi.suse.de> <200602212105.38075.ak@suse.de> <20060221.121948.60060362.davem@davemloft.net>
In-Reply-To: <20060221.121948.60060362.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212143.46721.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 21:19, David S. Miller wrote:
> From: Andi Kleen <ak@suse.de>
> Date: Tue, 21 Feb 2006 21:05:37 +0100
> 
> > The classic way is to just use touch_nmi_watchdog() somewhere
> > in the loop that does work. That touches the softwatchdog too
> > these days.
> 
> "jiffies" aren't advancing, since interrupts are disabled by
> release_console_sem(), so that doesn't work.
> 
> I tried that already :-)

Ah I see the problem I guess. When you restart then your 
timer interrupt catches up the missing jiffies very quickly
and that triggers the softwatchdog. 

Nasty. Perhaps it needs to look at xtime instead and 
let touch_softlockup_watchdog() update that.  But that could
break with NTP then. Perhaps using monotonic_clock() ? 

-Andi
 
