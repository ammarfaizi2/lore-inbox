Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWHJS3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWHJS3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWHJS3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:29:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:10431 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751446AbWHJS3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:29:24 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Oops in 2.6.17.7 running multiple eth bridges
Date: Thu, 10 Aug 2006 11:28:47 -0700
Organization: OSDL
Message-ID: <20060810112847.3d868ccc@localhost.localdomain>
References: <31296a430608101034v2ecfbf8an66510427da49af4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1155234529 26730 10.8.0.54 (10 Aug 2006 18:28:49 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 10 Aug 2006 18:28:49 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 19:34:22 +0200
"Peter M" <peter.mdk@gmail.com> wrote:

> I have built a multi bridge i386 machine with 8 eth devices which
> keeps crashing on me.
> 
> Kernel 2.6.7.17
> 
> I'm using a network card with 4 ports (tulip) and 4 r8169 based cards.
> 
> br0: eth0 eth1
> br1: eth2 eth3
> br2: eth3 eth4
> br3: eth5 eth6
> 
> Below crash came when I unplugged a cable on a running bridge. Today I
> have had two crashes without touching the cables but didn't get any
> usable syslog.
> 
> I have attached a number of info files which might help.
> 
> Regards
> Peter M.

Looks like you are running out of memory.  You will need more memory
to be able to hold all the receive rings data, as well as data in flight.
Rough estimate:

	R8169 := 4 * 256 (ringsize) * 2K  
	Tulip := 4 * 128  * 2K

That comes out to 3 Meg in use just being idle. Once you get going
it could easily be 3x that.

And that is for standard 1500 byte MTU. If you use large packets, you
will have problems with memory fragmentation and will probably have
to go to a bigger 64 bit machine and even more memory.
