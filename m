Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWAEX7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWAEX7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWAEX7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:59:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14987 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932282AbWAEX6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:58:51 -0500
Date: Fri, 6 Jan 2006 00:58:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105235838.GC3339@elf.ucw.cz>
References: <20051227220533.GA1914@elf.ucw.cz> <Pine.LNX.4.50.0512271957410.6491-100000@monsoon.he.net> <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.50.0601051329590.17046-100000@monsoon.he.net> <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060105230849.GN2095@elf.ucw.cz> <20060105234629.GA7298@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060105234629.GA7298@isilmar.linta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 06-01-06 00:46:29, Dominik Brodowski wrote:
> On Fri, Jan 06, 2006 at 12:08:49AM +0100, Pavel Machek wrote:
> > Ok, so lets at least add value-checking to .../power file, and prevent
> > userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
> > "arbitrary cookies". I'd like to use "on" and "off", but pcmcia
> > apparently depends on "2" and "0", so...
> > 
> > Any objections?
> 
> Sorry, but yes -- the same as before, minus the PCMCIA breakage.

I don't understand at this point.

Current code takes value from user, and passes it down to driver,
without any checking. If user writes 666 into the file, it will
happily pass down 666 to the driver. Driver does not expect 666 in
pm_message_t.event. It may oops, BUG_ON() or anything like that.

Shall I change 

#define PM_EVENT_SUSPEND 2

to

#define PM_EVENT_SUSPEND 1324

to get my point across? This is kernel-specific value, it should not
be exported to userland.
								Pavel

-- 
Thanks, Sharp!
