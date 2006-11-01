Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752095AbWKANDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbWKANDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWKANDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:03:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13961 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752095AbWKANC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:02:59 -0500
Subject: Re: 2.6.19-rc4-mm1: noidlehz problems
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061101122319.GA13056@elf.ucw.cz>
References: <20061101122319.GA13056@elf.ucw.cz>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 01 Nov 2006 14:02:57 +0100
Message-Id: <1162386177.23744.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 13:23 +0100, Pavel Machek wrote:
> Hi!
> 
> First, it would be nice if we had someone listed as a maintainer of
> noidlehz stuff...
> 
> Then... I'm getting strange messages from noidlehz each time I
> unplug/replug AC power (perhaps due to interrupt latency?).

there probably is a different story going on.
When you unplug/replug AC power, several bioses change the meaning of
the software C-states in your system.
(there is a mapping between software visible C states and the hardware
C-states)

In some (hardware) C-states, the local apic timer stops (as does the
TSC), while in others it keeps running. If you change from AC to
battery, the bios can change the meaning of a software C-state from one
where local apic timer keeps going to one where it stops. This obviously
upsets the hrtimers/tickless code since that uses local apic timer for
event generation....


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

