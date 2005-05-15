Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVEOLkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVEOLkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 07:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVEOLkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 07:40:16 -0400
Received: from one.firstfloor.org ([213.235.205.2]:6785 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261613AbVEOLkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 07:40:05 -0400
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
References: <20050513184806.GA24166@redhat.com>
	<20050514065753.GA28213@redhat.com>
	<20050514000723.73bd6e5a.akpm@osdl.org>
	<200505140631.59336.tomlins@cam.org>
	<1116067987.1183.9.camel@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: Sun, 15 May 2005 13:40:00 +0200
In-Reply-To: <1116067987.1183.9.camel@localhost.localdomain> (Alexander
 Nyberg's message of "Sat, 14 May 2005 12:53:07 +0200")
Message-ID: <m1psvsafan.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> writes:
>
> But uhm, it should take at least 5 seconds of no-interrupts before the
> NMI watchdog decides the box is dead so this is kind of weird.

There is a bug somewhere that makes it sometimes expire faster.
I found only one bug so far - touch_nmi_watchdog has a race
(fixed now in -mm*).  You can try if it still happens with the next -mm.

Somehow i doubt it is the race though because it should
be too unlikely to trigger this. Could be some other bug
too.

-Andi
