Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUAIApf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUAIApf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:45:35 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41485 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S265125AbUAIAp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:45:29 -0500
Date: Fri, 9 Jan 2004 01:45:25 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Message-ID: <20040109004525.GB545@alpha.home.local>
References: <20040107200556.0d553c40.skraw@ithnet.com> <20040107210255.GA545@alpha.home.local> <3FFCC430.4060804@candelatech.com> <20040108091441.3ff81b53.skraw@ithnet.com> <20040108084758.GB9050@alpha.home.local> <p0602042fbc2347a37845@[192.168.0.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p0602042fbc2347a37845@[192.168.0.3]>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 09:49:20AM -0800, Jonathan Lundell wrote:
> One place where you might want to know: an HA system where a 
> redundant interface is available to be configured in place of an 
> active interface. We'd like to know the state of the link on the 
> backup interface, which is logically down, as an indication that it's 
> hooked up and ready to go.

It's exactly under these conditions that I discovered the problem. None
of the interface was usable by the bonding driver, although one of them
was properly connected !

> It's unfortunate that the two conditions are conflated by most net drivers.

IMHO, saying "most net drivers" is unfair : tg3, tulip, 3c59x, starfire,
realtek, sis900, dl2k, pcnet32, and IIRC sunhme are OK. eepro100 is nearly
OK but has this annoying bug, and only older 10 Mbps drivers don't report
their status, often because the chip itself doesn't know.

Willy

