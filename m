Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTJFWJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 18:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbTJFWJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 18:09:00 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:58510 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261840AbTJFWI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 18:08:59 -0400
Date: Tue, 7 Oct 2003 00:08:47 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: vojtech@suse.cz
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20031006220847.GA5139@vana.vc.cvut.cz>
References: <20030912165044.GA14440@vana.vc.cvut.cz> <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com> <20030916232318.A1699@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916232318.A1699@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 11:23:18PM +0200, Andries Brouwer wrote:
> 
> I am especially interested in cases where people can reproduce
> an unwanted key repeat. The question is: is this a bug in our timer code
> or use of timers, or did the keyboard never send the key release code?
> 
> (#define DEBUG in i8042.c)

Hi,
  after three weeks running with DEBUG enabled I decided (well, I lost this patch
somewhere while patching my kernel sometime last week) to disable it - and kaboom, I
got (twice, but yesterday I rebooted box hard, as I thought that it is dead)
strange lockup, where box stoped reacting on keyboard. After playing with
mouse's cut&paste I was able to get at dmesg, and after 'setleds -V +num' keyboard
returned back to live.

  And it looks to me like a genuine race. When I was switching from console
with numlock enabled to console with numlock disabled, message below was printed
by kernel, and keyboard stopped working (probably waiting for second byte from
setleds command). I'll now reenable DEBUG in i8042, and problem will hopefully
disappear...

atkbd.c: Unknown key released (translated set 2, code 0x165, data 0xfa, on isa0060/serio0).

								Best regards,
									Petr Vandrovec
									vandrove@vc.cvut.cz
