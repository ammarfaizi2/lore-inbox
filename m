Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVDKU6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVDKU6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVDKU6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:58:36 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:63666 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261933AbVDKU5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:57:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [2.6.12-rc2][suspend] resume occuring twice before suspend to suspend-to-disk
Date: Mon, 11 Apr 2005 22:57:44 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20050411193108.56141.qmail@web88012.mail.re2.yahoo.com>
In-Reply-To: <20050411193108.56141.qmail@web88012.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504112257.44628.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 11 of April 2005 21:31, Shawn Starr wrote:
> I've noticed that when I do a suspend to disk. The
> machine suspends PCI devices once (I notice this
> because the ipw2200 wireless card shows its
> suspending, then it locks/parks the HD heads, but then
> all PCI devices are woken up and resume. The HD spins
> up and then dumps memory contents to swap partition,
> then it suspends all devices again? :)
> 
> Is this the right behaviour? 

It is like that by design.  The devices are suspened before we create the
system image (so that they do not get in the way) and we should wake
up some of them afterwards so that we can write the image to the swap
partition.  Currently, we wake up all devices, which is not very efficient,
but it is simple enough to allow us to hunt bugs more easily.  Finally, the
system is just powered off.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
