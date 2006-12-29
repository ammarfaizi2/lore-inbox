Return-Path: <linux-kernel-owner+w=401wt.eu-S1754065AbWL2DkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbWL2DkH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 22:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbWL2DkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 22:40:07 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:41957 "EHLO
	asav02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbWL2DkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 22:40:05 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAN8clEVKhRO4UGdsb2JhbACOAAEBKg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Rene Herman <rene.herman@gmail.com>
Subject: Re: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
Date: Thu, 28 Dec 2006 22:40:00 -0500
User-Agent: KMail/1.9.3
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <4592E685.5000602@gmail.com> <20061228191204.GB8940@redhat.com> <45943AE4.6080704@gmail.com>
In-Reply-To: <45943AE4.6080704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612282240.00784.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 16:45, Rene Herman wrote:
> Dave Jones wrote:
> 
> > On Wed, Dec 27, 2006 at 10:32:53PM +0100, Rene Herman wrote:
> 
> >> The bug where the kernel repetitively emits "atkbd.c: Spurious ACK
> >> on isa0060/serio0. Some program might be trying access hardware
> >> directly" (sic) on a panic, thereby scrolling away the information
> >> that would help in seeing what exactly the problem was (ie, "Unable
> >> to mount root fs" or something) is still present in 2.6.20-rc2.
> > 
> > Do you have a KVM ?  Quite a few of those seem to tickle this printk.
> 
> No, regular old PS/2 keyboard, directly connected. Due to that exact 
> uneventfullness and having seen it reported before recently (*) I 
> assumed everyone was seeing this. If not, I guess I can try to narrow it 
> down.
> 
> It's easy to test for anyone willing: just boot with "root=/dev/null" or 
> something as a kernel param. The printk's are in sync with the panic 
> code blinking the leds.
> 
> (*) Here there was supposed to be a link to the post I was refferring 
> to, but googling for it led to http://lkml.org/lkml/2006/11/13/300
> 
> Dmitry, could you ask Linus to pull the change? I find this to be an 
> exceedingly annoying bug. It's just so incredibly silly, having one part 
> of the kernel helpfully blink leds at you with another part going "hey, 
> dude! don't do that!"
> 

Hi Rene,

The change to suppress ACKs from paic blinking is already in Linus's tree.
I just tried booting with root=/dev/sdg and I had leds blinking but no
messages from atkbd were seen.

Could it be that you loaded older kernel by accident? Does anybody else
still seeing "Spurios ACK" messages during kernel panic?

-- 
Dmitry
