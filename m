Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVESByS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVESByS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 21:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVESByS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 21:54:18 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:51879 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262444AbVESByI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 21:54:08 -0400
Subject: Re: ACPI S3/APM suspend
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Ian Soboroff <isoboroff@acm.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9cfzmusbmvw.fsf@rogue.ncsl.nist.gov>
References: <9cfvf5gel2l.fsf@rogue.ncsl.nist.gov>
	 <9cfzmusbmvw.fsf@rogue.ncsl.nist.gov>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1116466723.5346.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 19 May 2005 11:38:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-05-19 at 00:59, Ian Soboroff wrote:
> Ian Soboroff <isoboroff@acm.org> writes:
> 
> > I recently reinstalled my laptop (Fujitsu P2110) with RHEL4, and I
> > found that neither ACPI S3 or APM suspend (booting with acpi=off) work
> > reliably with their stock kernel (a 2.6.9 derivative).  Sometimes
> > resuming works, but more often the computer locks up, or the keyboard
> > doesn't function respond.
> 
> Just tried with 2.6.11.10 using ACPI.  On resume, the mouse doesn't
> respond (there isn't even a cursor).  If I C-A-Backspace out of X, GDM
> needs to be specially HUP'd to restart.  But the mouse still doesn't
> work.

You will probably be able to address this by building psmouse and evdev
as modules and doing the following sequence:

1) chvt away from X
2) rmmod psmouse & evdev
3) suspend & resume as normal
4) modprobe psmouse & evdev
5) switch back

The hibernate script (see http://suspend2.net) can make this less
painful if you want it.

In the case of USB mice, you will probably want to unload not just
psmouse & evdev, but the whole set of USB modules.

Regards,

Nigel

> This was one of the failure modes in the RHEL 2.6.9-5.0.5 kernel.  (I
> know, I know, "ask RH for support", but they don't seem to have any of
> the ACPI or APM suspend bugs in their bugzilla anywhere near
> resolved.)
> 
> Ian
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 

