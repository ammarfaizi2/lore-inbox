Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161672AbWJDRLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161672AbWJDRLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161813AbWJDRLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:11:23 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:43041 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S1161672AbWJDRLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:11:21 -0400
From: Benjamin Schindler <bschindler@student.ethz.ch>
Organization: ETH
To: Matt Mackall <mpm@selenic.com>
Subject: Re: netconsole not working on 2.6.17.6
Date: Wed, 4 Oct 2006 19:10:44 +0200
User-Agent: KMail/1.9.4
Cc: Alan Menegotto <macnish@gmail.com>, linux-kernel@vger.kernel.org
References: <200609161651.21357.bschindler@student.ethz.ch> <200610041326.55048.bschindler@student.ethz.ch> <20061004160543.GX6412@waste.org>
In-Reply-To: <20061004160543.GX6412@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041910.44919.bschindler@student.ethz.ch>
X-OriginalArrivalTime: 04 Oct 2006 17:11:20.0288 (UTC) FILETIME=[1C72DE00:01C6E7D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 18:05, Matt Mackall wrote:
> On Wed, Oct 04, 2006 at 01:26:54PM +0200, Benjamin Schindler wrote:
> > On Tuesday 03 October 2006 18:37, you wrote:
> > > Benjamin Schindler wrote:
> > > > Hi
> > > >
> > > > I'm unsuccesfully trying to get networking to work - I've got two
> > > > boxes
> >
> > that
> >
> > > > can ping each other: 192.168.0.101 and 192.168.0.102 - I load the
> >
> > netconsole
> >
> > > > module:
> > > >
> > > > modprobe netconsole
> > > > netconsole=6666@192.168.0.102/eth0,6666@192.168.0.101/00:02:44:34:5d:
> > > >f6
> > > >
> > > > In dmesg I get:
> > > >
> > > > netconsole: local port 6666
> > > > netconsole: local IP 192.168.0.102
> > > > netconsole: interface eth0
> > > > netconsole: remote port 6666
> > > > netconsole: remote IP 192.168.0.101
> > > > netconsole: remote ethernet address 00:02:44:34:5d:f6
> > > > netconsole: network logging started
> > > >
> > > > I start wireshark/tcpdump whatever - and load a few modules just to
> >
> > produce
> >
> > > > some kernel messages. However, noething leaves the wire but I get all
> > > > the messages in dmesg.
> > > >
> > > > What's wrong here?
> > > >
> > > > Thanks
> > > > Benjamin Schindler
> > > >
> > > > P.s. please cc me as I'm not subscribed to this list
> > >
> > > Are you pointing to the correct MAC? Have you tried to compile the
> > > netconsole as built-in?
> >
> > Yes, I'm pointing at the correct MAC, but since wireshark doesn't see in
> > the networl, I doubt anything actually is sent.
> > No, I have not tried to compile netconsole into the kernel because of
> > flexibility. Anyway, I have investiaged further:
> > I ran this systemtap script:
> >
> > probe module("netconsole").function("write_msg@drivers/net/netconsole.c")
> > { printf("WriteMsg called\b")
> > }
> >
> > Once this script was run, I rmmod and modprobe'd my wireless-module a few
> > times to generate some dmesg output, but according to systemtap, this
> > function never gets called.
> > So, either the call to register_console in netconsole fails, is wrong or
> > there is a but in register_console
>
> The usual problem is that the console log level is set too low.

I did 'echo 9 4 1 7 > /proc/sys/kernel/printk' and nothing changed. I also 
tried to set the log level to 9 using sysrq (dmesg confirmed), but I still 
don't get any messages
Thanks
