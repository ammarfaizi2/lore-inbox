Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbTFRV6r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265560AbTFRV6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:58:47 -0400
Received: from palrel10.hp.com ([156.153.255.245]:50906 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265558AbTFRV6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:58:46 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.58330.522570.329438@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 15:12:42 -0700
To: Andi Kleen <ak@suse.de>
Cc: David Mosberger <davidm@napali.hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: add /proc/sys/kernel/cache_decay_ticks
In-Reply-To: <p73znkf2g9t.fsf@oldwotan.suse.de>
References: <200306182151.h5ILpMcx022062@napali.hpl.hp.com.suse.lists.linux.kernel>
	<p73znkf2g9t.fsf@oldwotan.suse.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 19 Jun 2003 00:05:18 +0200, Andi Kleen <ak@suse.de> said:

  Andi> David Mosberger <davidm@napali.hpl.hp.com> writes:
  >> /proc/sys/kernel/cache_decay_ticks allows runtime tuning of the
  >> scheduler.  The earlier patch collided with the C99-ification of
  >> the file, so here is a retransmit.

  Andi> Funny, I did a similar patch for 2.4 a short time ago. But I
  Andi> would suggest one change before you merge that to
  Andi> mainline. The variable is currently used like this:

  Andi> #define CAN_MIGRATE_TASK(p,rq,this_cpu) \ ((jiffies -
  Andi> (p)->last_run > cache_decay_ticks) && \o

  Andi> Which means 0 means 1 jiffie. For a tunable it would be useful
  Andi> to be able to turn it off completely, which means the > needs
  Andi> to be replaced with a >=. Unfortunately this requires changes
  Andi> in the architectures too to subtract one. But it would make it
  Andi> more useful. I would do the change before exposing it.

I don't see why the two have to be tied together.  I agree it would be
_nice_, but having /proc/sys/kernel/cache_decay_ticks in it's current
form is much better than nothing at all.

	--david
