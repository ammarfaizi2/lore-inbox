Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSJMMZe>; Sun, 13 Oct 2002 08:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSJMMZe>; Sun, 13 Oct 2002 08:25:34 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:63994 "EHLO
	mg.homelinux.net") by vger.kernel.org with ESMTP id <S261507AbSJMMZd>;
	Sun, 13 Oct 2002 08:25:33 -0400
Date: Sun, 13 Oct 2002 14:31:05 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange load spikes on 2.4.19 kernel
Message-ID: <20021013123105.GA6304@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0210130202070.17395-100000@coffee.psychology.mcmaster.ca> <113001c27282$93955eb0$1900a8c0@lifebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113001c27282$93955eb0$1900a8c0@lifebook>
User-Agent: Mutt/1.4i
X-Message-Flag: If you do not see this message correctly, stop using Outlook.
X-GPG-Fingerprint: 8121 AD32 F00A 8094 748A  6CD0 9157 445D E7A6 D78F
X-GPG-Key: http://ice.dammit.lt/~mgedmin/mg-pgp-key.txt
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 04:34:21PM +1000, Rob Mueller wrote:
> Also Let me do a calculation, though I have no idea if this is right or
> not...
> a) the first item in the uptime output is 'system load average for the last
> 1 minute'
> b) it seems to only update/recalculate every 5 seconds
> c) it jumps from < 1 to 20 in 1 interval (eg 5 seconds)
> 
> This means that for it to jump from < 1 to 20 in 5 seconds, there must be on
> average about 60/5 * 20 = 240 processes blocked over those 5 seconds waiting
> for run time of some sort for the load to jump 20 points. Is that right?

Load is an exponential average, recalculated according to this formula
(see CALC_LOAD in sched.h) every five seconds:

  load1 = load1 * exp + n * (1 - exp)

where exp = 1/exp(5sec/1min) ~= 1884/2048 ~= 0.92
      n = the number of running tasks at the moment

To jump from 0.21 to 27.65 in 5 second (1 update), n would have to be
343.  Wow.  (Substituting the numbers for 5 and 15 minute averages I get
n of about 362 and 352).

Can somebody check my math?

Marius Gedminas
-- 
Never trust a computer you can't repair yourself.

