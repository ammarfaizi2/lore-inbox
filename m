Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUG2WSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUG2WSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUG2WSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:18:00 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:46745 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267466AbUG2WR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:17:58 -0400
Subject: Re: fixing usb suspend/resuming
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>,
       Alexander Gran <alex@zodiac.dnsalias.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200407291451.05630.oliver@neukum.org>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org>
	 <20040729083543.GG21889@openzaurus.ucw.cz>
	 <1091103438.2703.13.camel@desktop.cunninghams>
	 <200407291451.05630.oliver@neukum.org>
Content-Type: text/plain
Message-Id: <1091139316.2703.18.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 30 Jul 2004 08:15:16 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-29 at 22:51, Oliver Neukum wrote:
> > Regarding the spinning down before suspending to disk, I have a patch in
> > my version that adds support for excluding part of the device tree when
> > calling drivers_suspend. I take the bdevs we're writing the image to,
> > trace the structures to get the relevant device tree entry/ies and then
> > move (in the correct order) those devices and their parents from the
> > active devices list to a 'dont' touch' list (I don't call it that in
> 
> How do you deal with md, loop, etc... ?

The loop thread is NOFREEZE, so it should work fine. Until you said it,
I hadn't considered md, but it shouldn't be too hard to add some more
code to check if the devices are part of raid arrays. The other devices
could be given the same treatment.

As far as setting them up again at boot time, I've just added proper
initrd support, so one will be able to do any configuration needed from
an initrd (provided filesystems aren't mounted), get suspend to check if
it needs to resume and then carry on in the rest of the initrd mounting
filesystems and so on.

Regards,

Nigel

