Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTKZUFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTKZUFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:05:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:28830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264300AbTKZUFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:05:04 -0500
Date: Wed, 26 Nov 2003 12:04:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
In-Reply-To: <20031126195049.GT8039@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0311261202050.1524@home.osdl.org>
References: <200311261212.10166.gene.heskett@verizon.net>
 <200311261415.52304.gene.heskett@verizon.net> <20031126193059.GS8039@holomorphy.com>
 <200311261443.43695.gene.heskett@verizon.net> <20031126195049.GT8039@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Nov 2003, William Lee Irwin III wrote:

> On Wed, Nov 26, 2003 at 02:43:43PM -0500, Gene Heskett wrote:
> > No, it just hangs forever on the su command, never coming back.
> > everything else I tried, which wasn't much, seemed to keep on working
> > as I sent that message with that hung su process in another shell on
> > another window.  I'm an idiot, normally running as root...
> > I've rebooted, not knowing if an echo 0 to that variable would fix it
> > or not, I see after the reboot the default value is 0 now.
>
> Okay, then we need to figure out what the hung process was doing.
> Can you find its pid and check /proc/$PID/wchan?

I've seen this before, and I'll bet you 5c (yeah, I'm cheap) that it's
trying to log to syslogd.

And syslogd is stopped for some reason - either a bug, a mistaken SIGSTOP,
or simply because the console has been stopped with a simple ^S.

That won't stop "su" working immediately - programs can still log to
syslogd until the logging socket buffer fills up. Which can be _damn_
frsutrating to find (I haven't seen this behaviour lately, but I remember
being perplexed like hell a long time ago).

			Linus
