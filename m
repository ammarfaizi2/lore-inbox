Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161536AbWJDQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161536AbWJDQHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161526AbWJDQHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:07:19 -0400
Received: from waste.org ([66.93.16.53]:10202 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1161483AbWJDQHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:07:16 -0400
Date: Wed, 4 Oct 2006 11:05:43 -0500
From: Matt Mackall <mpm@selenic.com>
To: Benjamin Schindler <bschindler@student.ethz.ch>
Cc: Alan Menegotto <macnish@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: netconsole not working on 2.6.17.6
Message-ID: <20061004160543.GX6412@waste.org>
References: <200609161651.21357.bschindler@student.ethz.ch> <452291C3.8090503@gmail.com> <200610041326.55048.bschindler@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610041326.55048.bschindler@student.ethz.ch>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 01:26:54PM +0200, Benjamin Schindler wrote:
> On Tuesday 03 October 2006 18:37, you wrote:
> > Benjamin Schindler wrote:
> > > Hi
> > >
> > > I'm unsuccesfully trying to get networking to work - I've got two boxes 
> that 
> > > can ping each other: 192.168.0.101 and 192.168.0.102 - I load the 
> netconsole 
> > > module:
> > >
> > > modprobe netconsole 
> > > netconsole=6666@192.168.0.102/eth0,6666@192.168.0.101/00:02:44:34:5d:f6
> > >
> > > In dmesg I get: 
> > >
> > > netconsole: local port 6666
> > > netconsole: local IP 192.168.0.102
> > > netconsole: interface eth0
> > > netconsole: remote port 6666
> > > netconsole: remote IP 192.168.0.101
> > > netconsole: remote ethernet address 00:02:44:34:5d:f6
> > > netconsole: network logging started
> > >
> > > I start wireshark/tcpdump whatever - and load a few modules just to 
> produce 
> > > some kernel messages. However, noething leaves the wire but I get all the 
> > > messages in dmesg.
> > >
> > > What's wrong here?
> > >
> > > Thanks
> > > Benjamin Schindler
> > >
> > > P.s. please cc me as I'm not subscribed to this list
> > >   
> > Are you pointing to the correct MAC? Have you tried to compile the 
> > netconsole as built-in?
> > 
> Yes, I'm pointing at the correct MAC, but since wireshark doesn't see in the 
> networl, I doubt anything actually is sent. 
> No, I have not tried to compile netconsole into the kernel because of 
> flexibility. Anyway, I have investiaged further:
> I ran this systemtap script: 
> 
> probe module("netconsole").function("write_msg@drivers/net/netconsole.c") {
>         printf("WriteMsg called\b")
> }
> 
> Once this script was run, I rmmod and modprobe'd my wireless-module a few 
> times to generate some dmesg output, but according to systemtap, this 
> function never gets called. 
> So, either the call to register_console in netconsole fails, is wrong or there 
> is a but in register_console

The usual problem is that the console log level is set too low.

-- 
Mathematics is the supreme nostalgia of our time.
