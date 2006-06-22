Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWFVLzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWFVLzT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWFVLzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:55:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29410 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161089AbWFVLzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:55:18 -0400
Subject: Re: Dropping Packets in 2.6.17
From: Arjan van de Ven <arjan@infradead.org>
To: danial_thom@yahoo.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060622113147.3496.qmail@web33304.mail.mud.yahoo.com>
References: <20060622113147.3496.qmail@web33304.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 13:55:16 +0200
Message-Id: <1150977316.3120.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 04:31 -0700, Danial Thom wrote:
> I'm trying to make a case for using linux as a
> network appliance, but I can't find any
> combination of settings that will keep it from
> dropping packets at an unacceptably high rate.
> The test system is a 1.8Ghz Opteron with intel
> gigE cards running 2.6.17. I'm passing about 70K
> pps through the box, which is a light load, but
> userland activities (such as building a kernel)
> cause it to lose packets, even with backlog set
> to 20000. I had the same problem with 2.6.12 and
> abandoned the effort. Has anything been done
> since to give priority to networking? You can't
> have a network appliance drop packets when some
> application is gathering stats or a user is
> looking at a graph. What tunings are available?

Hi Danial,

the most likely tunable that will help you is

/proc/sys/vm/min_free_kbytes

For the router kind of device that one usually needs bumping a bit;
without the bumping the VM doesn't see enough "normal" activity to tune
it's emergency/interrupt handling buffers (and most networking
allocations happen in interrupt context), and then ends up failing
allocations in interrupt context, which leads to dropped packets.

Greetings,
   Arjan van de Ven

