Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbUKBONc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbUKBONc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKBOM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:12:59 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:58712 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262023AbUKBOD0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:03:26 -0500
Subject: Re: [PATCH 2.4] usb serial write fix
From: Paul Fulghum <paulkf@microgate.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041101193616.2d517e77@lembas.zaitcev.lan>
References: <mailman.1099321382.10097.linux-kernel2news@redhat.com>
	 <20041101193616.2d517e77@lembas.zaitcev.lan>
Content-Type: text/plain
Message-Id: <1099404208.2856.25.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 02 Nov 2004 08:03:29 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-01 at 21:36, Pete Zaitcev wrote:

> Why testing for signals? Do you expect any?

post_helper can run in a user process as well
as keventd. The user process can get a signal
like HUP to pppd.

> Tying up a shared thread just because of this just does not look right.

OK. 

post_helper could hold the job and reschedule the work routine,
so it does not block other work routines.
Throwing the job away is not workable.

> Looking at pl2303 in 2.4, I do not see any difference between its ->write
> method and generic_write which would be specific to pl2303. The key
> difference is that generic_write participates in the protocol governed by
> port->write_busy. So why don't you simply drop pl2303_write?

That might fix the problem for pl2303, but if other component drivers
have driver specific write routines that do not implement this protocol,
they will have the problem also.

It seemed a better to fix this in one location instead
of auditing all component drivers and replicating a
fix in multiple places. Maybe no other component drivers
implement a driver specific write routine, I have not checked.

If pl2303_write has no necessary difference from generic_write
then pl2303_write should certainly be dropped.

-- 
Paul Fulghum
paulkf@microgate.com

