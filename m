Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUJGPfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUJGPfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUJGPfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:35:46 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:6371 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S267312AbUJGPfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:35:40 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: PATCH/RFC: usbcore wakeup updates (3/4)
Date: Thu, 7 Oct 2004 08:35:53 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410041407.47500.david-b@pacbell.net> <20041006105155.GE4723@openzaurus.ucw.cz>
In-Reply-To: <20041006105155.GE4723@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410070835.53261.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wednesday 06 October 2004 3:51 am, Pavel Machek wrote:
> > There were already some hooks in usbcore, but they were only
> > configurable for root hubs ... but not keyboards, mice, Ethernet
> > adapters, or other devices.
> 
> That "when asked about D1 enter D3" bit worries me a bit, because
> it is (ugly) workaround to core problems, but I can survive it.

I'm not sure what a better fix would be though ... I think WIndows
doesn't bother entering a low power state at all in such cases.
Which seems particularly pointless for the typical USB controller,
which is probably idle at that point already, and which can't take
all that much longer to resume from D3hot than from D1.

But that part is peripheral to the thrust of this set of patches.

Do you think adding those two bits to per-device PM state
is basically a good way to introduce their wakeup capabilities
to the PM core?  Suggestions on the next step?


> Introducing enums where PCI suspend level is stored in u32
> would be welcome... 

I'm not averse to enums, especially once sparse does good things
with them, but I still think that sort of change would just be nibbling
around the edges of a larger problem.  (Which should be addressed
by different patches making device power states/policies, like G0/D1
or "idle yourself", be types that are fully distinct from system power
states like G1/S3, and for which abuse creates compiler errors.)

- Dave


> 
> 				Pavel
> -- 
> 64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
> 
> 
