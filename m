Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVFNORL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVFNORL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVFNORL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:17:11 -0400
Received: from gs.bofh.at ([193.154.150.68]:8403 "EHLO gs.bofh.at")
	by vger.kernel.org with ESMTP id S261234AbVFNORE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:17:04 -0400
Subject: Re: Add pselect, ppoll system calls.
From: Bernd Petrovitsch <bernd@firmix.at>
To: =?ISO-8859-1?Q?Mattias Engdeg=E5rd?= <mattias@virtutech.se>
Cc: Valdis.Kletnieks@vt.edu, cfriesen@nortel.com, jakub@redhat.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       dwmw2@infradead.org, drepper@redhat.com
In-Reply-To: <200506141407.j5EE7sZ11314@virtutech.se>
References: <200506131938.j5DJcKc10799@virtutech.se>
	 <42ADE52E.1040705@nortel.com> <200506132008.j5DK8t010817@virtutech.se>
	 <200506132023.j5DKNhoG021339@turing-police.cc.vt.edu>
	 <200506141407.j5EE7sZ11314@virtutech.se>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 14 Jun 2005 16:16:23 +0200
Message-Id: <1118758583.11557.87.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-14 at 16:07 +0200, =?ISO-8859-1?Q?Mattias Engdeg=E5rd?=
wrote:
> >Monotonic clocks are guaranteed to not go backward. A sudden warp 35
> >seconds into the future when you have timers set for 15 and 20
> >seconds into the future is still ugly....
> 
> I don't have the POSIX specs handy, but I see no reason we could not let
> it use a warpless monotonic clock.

You have already one - the uptime of the system.

> The problem of timeouts going wild when time is being warped applies
> to syscalls using relative timeouts as well. Even when a relative
> timeout is wanted, it is usually transformed (via gettimeofday or

Doing "Relative timeouts" with "gettimeofday()" is a strategic error.
Specify the timeout und use (the return value of) times(2) for this.

Use "gettimeofday()" and similar just if (and only if) you communicate
with the user (read: that is a pure user interface issue).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

