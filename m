Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266298AbUA2RZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 12:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUA2RZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 12:25:24 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:42644 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266298AbUA2RYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 12:24:31 -0500
Message-ID: <401941C4.4070502@nortelnetworks.com>
Date: Thu, 29 Jan 2004 12:24:20 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mj@ucw.cz
Subject: question about PCI setup with multiple CPUs on the PCI bus(es)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have an interesting scenario thats causing us some headaches, and 
before we go and re-invent the wheel, I've been asked to see if there's 
any others that have had to do something similar.

We have a main board with a processor on it and a number of PCI buses 
connected via bridges, with various devices on the buses.  There are a 
number of PMC slots on two of the buses two which are connected PMC 
processor boards, each of which has a cpu, memory, various devices, and 
a PCI bridge.

The problem we are running into is as follows:
1) the main board boots up, enumerates and configures the pci device 
space, and boots the daughterboards
2) the daughterboards boot up, enumerate and (re)configure the pci 
device space (differently than the cpu on the mainboard), and screw 
everything up

We changed to kernel on the daughterboards to not touch PCI at all, and 
everything worked fine.  However, one of the daughterboards (which is on 
its own pci bus separate from the others) needs to control two PCI devices.

We tried to modify the PCI code to just go out and discover what was in 
PCI space, not configure any of it.  However, as it did this it 
reprogrammed the PCI bridges, wrecking the configuration that the cpu on 
the main board expected.

Surely we aren't the only people that want to put multiple CPUs on a 
single PCI space.  How have people handled this in the past?  Ideally 
what I'm looking for is a CONFIG_NO_MANGLE_PCI or something to that 
effect. As a last resort we are considering hardcoding the bus/device 
topology for the two drivers on special daughterboard, but this seems 
really kludgy.

Anyone have any advice?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

