Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVKDRoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKDRoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVKDRn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:43:59 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:57946 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750762AbVKDRn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:43:59 -0500
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] driver model wakeup flags
Date: Fri, 4 Nov 2005 09:43:56 -0800
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <11304810223093@kroah.com> <20051029075540.GA2579@openzaurus.ucw.cz> <20051102215912.GL23247@kroah.com>
In-Reply-To: <20051102215912.GL23247@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511040943.56887.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2005 1:59 pm, Greg KH wrote:
> On Sat, Oct 29, 2005 at 09:55:41AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > >   * There's a writeable sysfs "wakeup" file, with one of two values:
> > >       - "enabled", when the policy is to allow wakeup
> > >       - "disabled", when the policy is not to allow it
> > >       - "" if the device can't currently issue wakeups
> > 
> > Could we either get "not-supported" value here, or remove the file if it is not
> > supported? Having empty file is ugly...
> 
> Sure, have a patch for this?  :)

Turns out that "remove if not supported" is impractical; I did have
that implemented, and backed it out as I got deeper into testing.

For one example, the "can wakeup" for USB devices is a function of what
configuration the device is in ... so a device with two configurations
(call them #5 and #42) as well as "unconfigured" (config #0) might
not support wakeup in two of its three states; maybe only #42 supports
remote wakeup.

Yes, those empty files bothered me a bit too.

- Dave
