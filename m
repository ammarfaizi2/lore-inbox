Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUAKIzN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUAKIzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:55:13 -0500
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:29848 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id S265804AbUAKIzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:55:09 -0500
Date: Sun, 11 Jan 2004 00:55:06 -0800
From: Simon Kirby <sim@netnation.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 SMP lockups
Message-ID: <20040111085506.GA6834@netnation.com>
References: <20040109210450.GA31404@netnation.com> <Pine.LNX.4.58L.0401101719400.1310@logos.cnet> <20040110144049.5e195ebd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110144049.5e195ebd.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 02:40:49PM -0800, Andrew Morton wrote:

> Presumably it's spinning on the lock with interrupts enabled.  Make that
> the `NMI' counters in /proc/interrupts are incrementing for all CPUs.

Actually, on one of the boxes it doesn't seem to be working at all:

activating NMI Watchdog ... done.
testing NMI watchdog ... CPU#0: NMI appears to be stuck!  

This is on a Tyan Dual AMD MPX board with two MP 2000+ CPUs. 
/proc/interrupts shows:

           CPU0       CPU1       
  0:    4897433    4904751    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 16:     699524     700761   IO-APIC-level  dpti0
 19:   12480119   12480207   IO-APIC-level  eth0
NMI:          0          0 
LOC:    9801455    9801319 
ERR:          0
MIS:         13

I'll try reenabling it on the other (Intel) boxes where I think it
actually does work, and see if anything results.

> sysrq-T would be best.

I'll do the serial console dance next time and get some sysrq-T output.

Simon-
