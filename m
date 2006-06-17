Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWFQREO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWFQREO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 13:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWFQREO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 13:04:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750722AbWFQREO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 13:04:14 -0400
Date: Sat, 17 Jun 2006 10:04:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: clocksource
Message-Id: <20060617100407.3596be29.akpm@osdl.org>
In-Reply-To: <1150428084.15267.74.camel@cog.beaverton.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<Pine.LNX.4.64.0606050141120.17704@scrub.home>
	<1149538810.9226.29.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606052226150.32445@scrub.home>
	<1149622955.4266.84.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.64.0606070005550.32445@scrub.home>
	<1149753904.2764.24.camel@leatherman>
	<Pine.LNX.4.64.0606151319440.32445@scrub.home>
	<1150428084.15267.74.camel@cog.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006 20:21:24 -0700
john stultz <johnstul@us.ibm.com> wrote:

> The method I came up with is really just P-D (proportional-derivative)
> control, but that should be ok since the adjustments are all linear so I
> don't think the integral control is necessary (control theorists can
> pipe in here).

Boy, that takes me back.  If you don't feed back the integral you'll end up
with an output which has a steady-state offset error against the control
point (unless the forward gain is infinite, and it never is).  I don't know
if that matters here, but it cannot be good.

If you feed back the integral of the error then it introduces the
possibility of instability.  Probably in this application you can just
overdamp the thing to avoid that.  It'll make it slower to respond to
changes in the setpoint.
