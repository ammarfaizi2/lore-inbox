Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUJEVxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUJEVxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUJEVxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:53:21 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:35776 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S266143AbUJEVxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:53:19 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Tue, 5 Oct 2004 14:53:27 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410041400.04385.david-b@pacbell.net> <200410051309.02105.david-b@pacbell.net> <20041005201531.GA5763@elf.ucw.cz>
In-Reply-To: <20041005201531.GA5763@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410051453.27629.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 October 2004 1:15 pm, Pavel Machek wrote:

> > Also, so strncmp() can be used.  It won't matter if the sysadmin goes
> > 
> >    echo -n enabled > wakeup
> >    echo enabled > wakeup
> 
> Well, you could make that 0,1. That would be more sysfs-style...

Only for things like detach_state and power_state, which shouldn't
be numbers in the first place ... :)

The /sys/module/*/OPTION strings use Y/N for booleans, and
maybe sysfs should actually have generic code to read/write
such boolean values.


> On the second thought, perhaps file simply should not be there if
> wakeup is not supported.

That doesn't work too well for things like USB, where one config
may support wakeup but another doesn't ... and unconfigured
devices never support it.  The "can_support" value changes
over time.

- Dave
