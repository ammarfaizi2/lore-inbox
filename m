Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbTELTu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTELTu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:50:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59277 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262438AbTELTuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:50:55 -0400
Date: Mon, 12 May 2003 11:57:58 -0700 (PDT)
Message-Id: <20030512.115758.39166911.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make clip modular
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305121933.h4CJXM511323@relax.cmf.nrl.navy.mil>
References: <200305121933.h4CJXM511323@relax.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Mon, 12 May 2003 15:33:22 -0400

   this patch lets one build clip as a module.
   
This doesn't work and is quite racey.

   +			if (!atm_clip_ops || !try_module_get(atm_clip_ops->owner)) {

Q: What prevents atm_clip_ops from going NULL between the
   !atm_clip_ops test and the atm_clip_ops->owner dereference?

A: Nothing.

Therefore you have to protect these things some how, I would
suggest using a semaphore, put it right next to atm_clip_ops
and hold it around register, derferegister, and code sequence
like this one trying to get a reference to it.

The various ioctl hooks in net/socket.c are good models to
work from.

MPOA/LEC/MPC probably have nearly identical bugs and it would
be great if you could fix them up too.
