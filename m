Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272607AbTHEJsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 05:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272611AbTHEJsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 05:48:50 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:1995 "EHLO gaston")
	by vger.kernel.org with ESMTP id S272607AbTHEJsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 05:48:22 -0400
Subject: Re: [PATCH] airo driver: fix races, oops, etc..
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Javier Achirica <achirica@telefonica.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0308051048130.2746-100000@tudela.mad.ttd.net>
References: <Pine.SOL.4.30.0308051048130.2746-100000@tudela.mad.ttd.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060076891.615.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 05 Aug 2003 11:48:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 10:53, Javier Achirica wrote:
> I've integrated this patch in my code. I've done a major change: Instead
> of using schedule_delayed_work(), I create a new workqueue and use
> queue_work() on that queue. As all tasks sleep in the same lock, I can
> queue them there and make them sleep instead of requeueing them.
> 
> I haven't sent them to Jeff yet, as I want to do more testing. If you want
> to help testing them, please tell me.

Well... creating a work queue means you create one thread per CPU, that
sucks a bit don't think ? Maybe using a single thread for the driver
with your own queuing primitives...

Ben.
