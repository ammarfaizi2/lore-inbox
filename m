Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267332AbTAPXew>; Thu, 16 Jan 2003 18:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTAPXew>; Thu, 16 Jan 2003 18:34:52 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:63492
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267332AbTAPXev>; Thu, 16 Jan 2003 18:34:51 -0500
Date: Thu, 16 Jan 2003 18:43:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Joel Becker <Joel.Becker@oracle.com>
cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH] hangcheck-timer
In-Reply-To: <20030116231727.GV20972@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0301161841570.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Joel Becker wrote:

> Folks,
> 	Attached is a patch adding hangcheck-timer.  It is used to detect
> when the system goes out to lunch for a period of time, and then
> returns.  This is interesting for debugging drivers as well as for
> clustering environments.
> 	The module sets a timer.  When the timer goes off, it then uses
> get_cycles() to determine how much real time has passed.
> 	On a normal system, the real elapsed time will be almost
> identical to the expected timer duration.  However, if a device decided
> to udelay for 60 seconds (or some other circumstance), the module takes
> notice.  If the margin of error passes a threshold, the driver prints a
> warning or the machine is rebooted.
> 	There are three parameters.

NMI watchdog? Doesn't look like this can catch cases where you have 
interrupts disabled and spinning on a lock, if you manage to run this code 
then the box isn't really locked up. In which case the software watchdog 
should be as good as this.

	Zwane
-- 
function.linuxpower.ca

