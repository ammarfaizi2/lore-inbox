Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268231AbTB1WU6>; Fri, 28 Feb 2003 17:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268232AbTB1WU5>; Fri, 28 Feb 2003 17:20:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268231AbTB1WUx>;
	Fri, 28 Feb 2003 17:20:53 -0500
Date: Fri, 28 Feb 2003 14:26:25 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: ak@suse.de, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: [Bug 420] New: Divide by zero  (/proc/sys/net/ipv4/neigh/DEV/base_reachable_time)
Message-Id: <20030228142625.1a53da75.rddunlap@osdl.org>
In-Reply-To: <3E5FE165.C8BABD4@libero.it>
References: <27440000.1046453828@[10.10.2.4].suse.lists.linux.kernel>
	<p733cm86yv0.fsf@amdsimf.suse.de>
	<3E5FE165.C8BABD4@libero.it>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003 23:23:33 +0100
Abramo Bagnara <abramo.bagnara@libero.it> wrote:

| Andi Kleen wrote:
| > 
| > "Martin J. Bligh" <mbligh@aracnet.com> writes:
| > >
| > >     echo 0 > /proc/sys/net/ipv4/neigh/DEV/base_reachable_time
| > >
| > >   But neigh_rand_reach_time() divide by its argument.
| > >
| > >     unsigned long neigh_rand_reach_time(unsigned long base)
| > >     {
| > >       return (net_random() % base) + (base>>1);
| > >     }
| > 
| > Don't do that then. The sysctl is root-only. There are lots of ways to
| > break the system by writing bogus values into root only configuration
| > options. That is why they are root only
| > 
| > I would close the report as WONTFIX.
| 
| Don't this argument bring to the weird equality:
| 
| root user == infallible guy
| 
| IMHO the "if you make a typo you crash the machine" should be avoided
| (at least when feasible without drawbacks).

I agree with that.
It's worth making a patch and letting the maintainer reject it.

Of course, there are still plenty of other ways to write to /proc and kill
the system.

--
~Randy
