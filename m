Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131782AbRCOQ3X>; Thu, 15 Mar 2001 11:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131784AbRCOQ3N>; Thu, 15 Mar 2001 11:29:13 -0500
Received: from zeus.kernel.org ([209.10.41.242]:18134 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131782AbRCOQ3B> convert rfc822-to-8bit;
	Thu, 15 Mar 2001 11:29:01 -0500
Date: Thu, 15 Mar 2001 17:20:18 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mårten Wikström <Marten.Wikstrom@framfab.se>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: How to optimize routing performance
In-Reply-To: <Pine.LNX.4.21.0103150929080.4165-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0103151705170.27951-100000@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Rik van Riel wrote:

> On Thu, 15 Mar 2001, [ISO-8859-1] Mårten Wikström wrote:
> 
> > I've performed a test on the routing capacity of a Linux 2.4.2 box
> > versus a FreeBSD 4.2 box. I used two Pentium Pro 200Mhz computers with
> > 64Mb memory, and two DEC 100Mbit ethernet cards. I used a Smartbits
> > test-tool to measure the packet throughput and the packet size was set
> > to 64 bytes. Linux dropped no packets up to about 27000 packets/s, but
> > then it started to drop packets at higher rates. Worse yet, the output
> > rate actually decreased, so at the input rate of 40000 packets/s
> > almost no packets got through. The behaviour of FreeBSD was different,
> > it showed a steadily increased output rate up to about 70000 packets/s
> > before the output rate decreased. (Then the output rate was apprx.
> > 40000 packets/s).
> 
> > So, my question is: are these figures true, or is it possible to
> > optimize the kernel somehow? The only changes I have made to the
> > kernel config was to disable advanced routing.
> 
> There are some flow control options in the kernel which should
> help. From your description, it looks like they aren't enabled
> by default ...

You want to have CONFIG_NET_HW_FLOWCONTROL enabled. If you don't the
kernel gets _alot_ of interrupts from the NIC and dosn't have any cycles
left to do anything. So you want to turn this on!

> At the NordU/USENIX conference in Stockholm (this february) I
> saw a nice presentation on the flow control code in the Linux
> networking code and how it improved networking performance.
> I'm pretty convinced that flow control _should_ be saving your
> system in this case.

That was probably Jamal Hadi and Robert Olsson. They have been optimizing
the tulip driver. These optimizations havn't been integrated with the
"vanilla" driver yet, but I hope the can integrate it soon.

They have one version that is very optimized and then they have one
version that have even more optimizations, ie. it uses polling at high
interruptload.

you will find these drivers here:
ftp://robur.slu.se/pub/Linux/net-development/
The latest versions are:
tulip-ss010111.tar.gz
and
tulip-ss010116-poll.tar.gz

> OTOH, if they _are_ enabled, the networking people seem to have
> a new item for their TODO list. ;)

Yup.

You can take a look here too:

http://robur.slu.se/Linux/net-development/jamal/FF-html/

This is the presentation they gave at OLS (IIRC)

And this is the final result:

http://robur.slu.se/Linux/net-development/jamal/FF-html/img26.htm

As you can see the throughput is a _lot_ higher with this driver.

One final note: The makefile in at least tulip-ss010111.tar.gz is in the
old format (not the new as 2.4.0-testX introduced), but you can copy the
makefile from the "vanilla" driver and It'lll work like a charm.

Please redo your tests with this driver and report the results to me and
this list. I really want to know how it compares against FreeBSD.

/Martin

