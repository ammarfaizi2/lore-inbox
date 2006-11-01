Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946600AbWKAGDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946600AbWKAGDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946602AbWKAGDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:03:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:23518 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946600AbWKAGDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:03:05 -0500
Message-ID: <45483887.3030702@garzik.org>
Date: Wed, 01 Nov 2006 01:02:47 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Karsten Keil <kkeil@suse.de>
Subject: Re: [PATCH 49/61] ISDN: fix drivers, by handling errors thrown by
 ->readstat()
References: <20061101053340.305569000@sous-sol.org> <20061101054422.145185000@sous-sol.org>
In-Reply-To: <20061101054422.145185000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Jeff Garzik <jeff@garzik.org>
> 
> This is a particularly ugly on-failure bug, possibly security, since the
> lack of error handling here is covering up another class of bug: failure to
> handle copy_to_user() return values.
> 
> The I4L API function ->readstat() returns an integer, and by looking at
> several existing driver implementations, it is clear that a negative return
> value was meant to indicate an error.
> 
> Given that several drivers already return a negative value indicating an
> errno-style error, the current code would blindly accept that [negative]
> value as a valid amount of bytes read.  Obvious damage ensues.
> 
> Correcting ->readstat() handling to properly notice errors fixes the
> existing code to work correctly on error, and enables future patches to
> more easily indicate errors during operation.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> Cc: Karsten Keil <kkeil@suse.de>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>

No objection, but I would think that you would also want the companion 
patch:

commit 7786ce192fc4917fb9b789dd823476ff8fd6cf66
Author: Jeff Garzik <jeff@garzik.org>
Date:   Tue Oct 17 00:10:40 2006 -0700

     [PATCH] ISDN: check for userspace copy faults

     Most of the ISDN ->readstat() implementations needed to check
     copy_to_user() and put_user() return values.


