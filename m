Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbUAHRtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbUAHRtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:49:51 -0500
Received: from iris.coastside.net ([207.213.212.14]:57763 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP id S265678AbUAHRte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:49:34 -0500
Mime-Version: 1.0
Message-Id: <p0602042fbc2347a37845@[192.168.0.3]>
In-Reply-To: <20040108084758.GB9050@alpha.home.local>
References: <20040107200556.0d553c40.skraw@ithnet.com>
 <20040107210255.GA545@alpha.home.local>
 <3FFCC430.4060804@candelatech.com>
 <20040108091441.3ff81b53.skraw@ithnet.com>
 <20040108084758.GB9050@alpha.home.local>
Date: Thu, 8 Jan 2004 09:49:20 -0800
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Problem with 2.4.24 e1000 and keepalived
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:47am +0100 1/8/04, Willy Tarreau wrote:
>On Thu, Jan 08, 2004 at 09:14:41AM +0100, Stephan von Krawczynski wrote:
>>  the situation is like this (exactly this works flawlessly with tulip):
>>
>>  - unplug all interfaces from the switches
>>  - reboot box
>>  - plug in _one_ interface
>>  - log into the box (yes, network works flawlessly)
>>  - start keepalived
>>  - now plug in rest of the interfaces
>>  - watch keepalived do _nothing_ (seems no UP event shows up)
>
>I agree with this description, and would add :
>   - mii-diag ethX or ethtool ethX report link down

Which is, IMO, a bug, albeit a kind of specification bug, given the 
way the drivers tend to be written. An Ethernet link can be up or 
down independent of the logical up/down state of the interface, and 
with most drivers the link state is hidden as long as the interface 
is logically down.

One place where you might want to know: an HA system where a 
redundant interface is available to be configured in place of an 
active interface. We'd like to know the state of the link on the 
backup interface, which is logically down, as an indication that it's 
hooked up and ready to go.

It's unfortunate that the two conditions are conflated by most net drivers.
-- 
/Jonathan Lundell.
