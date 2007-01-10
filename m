Return-Path: <linux-kernel-owner+w=401wt.eu-S964863AbXAJOat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbXAJOat (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 09:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbXAJOat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 09:30:49 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:53960 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964863AbXAJOas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 09:30:48 -0500
Date: Wed, 10 Jan 2007 15:30:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Bernhard Schiffner <bernhard@schiffner-limbach.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ntp.c : possible inconsistency?
In-Reply-To: <200701101423.36740.bernhard@schiffner-limbach.de>
Message-ID: <Pine.LNX.4.64.0701101516420.14458@scrub.home>
References: <200701101423.36740.bernhard@schiffner-limbach.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Jan 2007, Bernhard Schiffner wrote:

> trying to find reasons for some crazy ntpd-behavior I read
> http://lkml.org/lkml/2006/10/27/67
> 
> This thread doesn't result in a pulished patch, so I (hopefully) did what was 
> said there. The patch doesn't break my system, but it doesn't change ntpd's 
> crazyness too.
> Nevertheless it should be discussed again in the sense of preventing an 
> inconsistency.

Without a further explanation of this craziness, it's a little hard to 
discuss...

> PS:
> Can someone point me to the reason for doing txc->constant + 4, please?

The main reason is this part in ntpd/ntp_loopfilter.c of the ntp package:

        if (pll_nano) {
                ntv.offset = (int32)(clock_offset *
                    1e9 + dtemp);
                ntv.constant = sys_poll;
        } else {
                ntv.offset = (int32)(clock_offset *
                    1e6 + dtemp);
                ntv.constant = sys_poll - 4;
        }

It uses the pll_nano switch to distinguish between the old and new ntp 
model. The kernel now implements the new ntp model, but the actual 
userspace interface hasn't changed yet, so the kernel undoes the 
compensation.

Here is bit more information about where this adjustments comes from:
http://www.ntp.org/ntpfaq/NTP-s-compat.htm#Q-COMPAT

bye, Roman
