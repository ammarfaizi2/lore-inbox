Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVHVW4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVHVW4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbVHVW4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:56:37 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:15502 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751434AbVHVW4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:56:34 -0400
Date: Sun, 21 Aug 2005 20:52:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: luben_tuikov@adaptec.com, jim.houston@ccur.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       davej@redhat.com, jgarzik@pobox.com
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
Message-Id: <20050821205214.2a75b3cf.akpm@osdl.org>
In-Reply-To: <1124680540.5068.37.camel@mulgrave>
References: <20050822003325.33507.qmail@web51613.mail.yahoo.com>
	<1124680540.5068.37.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> Since you won't post the usage code, just answer this: how does what
>  you're doing with idr differ from its originally designed consumer: the
>  posix timers which also do the idr_remove() in IRQ context?

erp.  posix_timers has its own irq-safe lock, so we're doing extra,
unneeded locking in that code path.

I think providing locking inside idr.c was always a mistake - generally we
rely on caller-provided locking for such things.
