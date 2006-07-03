Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWGCUxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWGCUxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWGCUxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:53:35 -0400
Received: from [65.19.161.204] ([65.19.161.204]:39950 "EHLO sorrow.cyrius.com")
	by vger.kernel.org with ESMTP id S932106AbWGCUxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:53:34 -0400
Date: Mon, 3 Jul 2006 22:52:38 +0200
From: Martin Michlmayr <tbm@cyrius.com>
To: Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 341801@bugs.debian.org, asd@suespammers.org,
       kevin@sysexperts.com
Subject: skge error; hangs w/ hardware memory hole
Message-ID: <20060703205238.GA10851@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We received the following bug report at http://bugs.debian.org/341801

| I have a Asus A8V with 4GB of RAM. When I turn on the hardware memory
| hole in the BIOS, the skge driver prints out this message:
|       skge hardware error detected (status 0xc00)
| and then does not work. Setting debug=16 doesn't really show anything.

Another users confirms this bug, saying:

| I'm running kernel 2.6.15-1-amd64-generic version 2.6.15-6, and see
| the very same thing.
| So I have to turn off the memory remapping feature that allows the
| system to see all 4 gig of memory, and thus lose the use of about 200
| megabytes of memory.
| Hardware: ASUS A8V Deluxe, 4G RAM, Athlon 64 3200+ CPU.

This problem has probably been there forever and also happens with the
sk98lin driver:

| With sk98lin under both 2.6.12 and 2.6.17 I get the following message,
| repeated countless times, and finally a hang: [this is copied from
| screen on to a sheet a paper and re-typed, beware typos]:

| eth0: Adapter failed
| eth0: -- ERROR --
| class: Hardware failure
| Nr: 0x264
| Msg: unexpected IRQ Status error

The bug is still present in 2.6.17 -mm6:

| -mm6 does not work with skge and the hardware memory hole. It gave
| these messages:

| skge eth0: enabling interface
| skge 0000:00:0a.0: PCI error cmd=0x117 status=0x22b0
| skge unable to clear error (so ignoring them)
| skge eth0: Link is up at 1000 Mbps, full duplex, flow control tx and rx

| DHCP never managed to get an IP address.

Any idea what to do about this?
-- 
Martin Michlmayr
http://www.cyrius.com/
