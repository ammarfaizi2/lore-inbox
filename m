Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTFDHeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 03:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTFDHeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 03:34:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18321 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263056AbTFDHeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 03:34:22 -0400
Date: Wed, 4 Jun 2003 09:47:37 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Yoann <linux-yoann@ifrance.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>,
       "Albert D.Cahalan" <acahalan@cs.uml.edu>
Subject: Re: another must-fix: major PS/2 mouse problem
Message-ID: <20030604094737.C5345@ucw.cz>
References: <1054431962.22103.744.camel@cube> <3EDD87FD.6020307@ifrance.com> <20030603232155.1488c02f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030603232155.1488c02f.akpm@digeo.com>; from akpm@digeo.com on Tue, Jun 03, 2003 at 11:21:55PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 11:21:55PM -0700, Andrew Morton wrote:

> We believe that it may be due to the ethernet driver holding interrupts off
> for too long when the traffic is heavy.

Note that this doesn't necessarily mean that the ethernet driver
disables the interrupts for a too long time, it just means that the
computer is only servicing the network interrupts at that time, and
since the mouse interrupt does have a lower priority, it's serviced
not very often and with huge delays.

In such a case the network driver should either use interrupt mitigation
if the cards supports it (reading many packets per one interrupt) or
switch to a polled mode.

> Does that seem to match your observations?  Does the problem happen when
> the net traffic is high?
> 
> Which ethernet driver are you using?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
