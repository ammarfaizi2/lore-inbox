Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265511AbVBFGI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbVBFGI7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 01:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVBFGI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 01:08:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9941 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265511AbVBFGIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 01:08:47 -0500
Date: Sun, 6 Feb 2005 01:08:40 -0500
From: Dave Jones <davej@redhat.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Intel AGP support attaching to wrong PCI IDs
Message-ID: <20050206060839.GA19330@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910502051745c25d6f@mail.gmail.com> <20050206040526.GA2908@redhat.com> <9e4733910502052158491b5ce3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910502052158491b5ce3@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 12:58:46AM -0500, Jon Smirl wrote:
 > On Sat, 5 Feb 2005 23:05:26 -0500, Dave Jones <davej@redhat.com> wrote:
 > > Take a peek at 'lspci -vv' output. You'll notice that the AGP
 > > capabilities are attached to the host bridge.
 > 
 > I see that now, why is it on the host bridge instead of the AGP
 > bridge? 

Not sure. Maybe its partly due to the host bridge having all the
smarts to deal with the memory controller.

 > So that means if we add drivers for the host bridges we have
 > to add the code to the AGP drivers. It also implies that we have to
 > load them.

Why exactly are you trying to write host bridge drivers anyway ?
Confused.

If there's a sensible reason for such drivers, we could at some
stage have the bridge drivers check for AGP capabilities, and
if found, start up the initialisation of the relevant AGP chipset
driver. (and then rip out the whole PCI detection stuff in agpgart).
This is quite a lot of work though, so unless there's a really
compelling reason, I don't think its worth doing.

Another way forward (somewhat hacky in one sense, but a lot cleaner in another)
would be to change the PCI code so that it'll load and init
multiple drivers that claim to support the same PCI ID.
This may cause issues for some other drivers however where
we have an old and a new driver with ID overlap.

So,.. what are you up to?

		Dave

