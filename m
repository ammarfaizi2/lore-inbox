Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWH0AEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWH0AEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 20:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWH0AEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 20:04:10 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:49234 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751265AbWH0AEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 20:04:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=s2+zEdpn55hMnj+aDcsoAp2S0tsldETVCVLo67z5/douLda178SVz5zI4AgagbzXE+8zONmNWGYRqU7gvx6IowNbzwDZny8hTA8idbFwoVxlIByHs20jwN4+1Jq5f5kcpronQr//kgLNDqOOvKz+fNmhVe0WzCWq5E+zXSAXSng=  ;
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: waking system up using RTC (was Re: rtcwakeup.c)
Date: Sat, 26 Aug 2006 17:04:04 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20060725124941.GD5034@ucw.cz> <200608261415.33353.david-b@pacbell.net> <20060826214342.GB3784@elf.ucw.cz>
In-Reply-To: <20060826214342.GB3784@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608261704.05017.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 August 2006 2:43 pm, Pavel Machek wrote:
> Hi!
> 
> > > Your new RTC driver seems to work for me (thinkpad x60), but no, I
> > > can't get wakeup using RTC to work:
> > 
> > Does it work using /proc/acpi/alarm?  In my experience, ACPI wakeup
> > doesn't work on Linux ... hence my pleasant surprise to see it work
> 
> No, I could not get it working using /proc/acpi/alarm.

Then I suspect that's the root cause of your problem ... ACPI code,
in either Linux or your BIOS, is not sufficiently cooperative.  All
that the rtc-acpi driver does is move the wakeup code, it doesn't
actually change what the /proc/acpi/alarm stuff does.


> No, machine actually suspends okay, it just does not wake up :-(.

The usual ACPI wakeup symptoms I've seen are the hardware giving the
signal, system starting to wake up, then botching somewhere early in
the resum.  So I suspect you're not actually getting the hardware
wakeup signal ... as if maybe it wasn't set up correctly.

You may be able to tell your BIOS to do the alarm by itself, and
then test to see whether Linux handles the wakeup side OK.


> rtc-acpi 00:07: AT compatible RTC (S4wake) (y3k), 1 month alarm

Seems like Intel's chips won't do one year alarms ... so sad.  :)

- Dave

