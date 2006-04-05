Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWDEHaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWDEHaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 03:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDEHaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 03:30:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751140AbWDEHaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 03:30:19 -0400
Date: Wed, 5 Apr 2006 00:29:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roger Luethi <rl@hellgate.ch>
Cc: zlynx@acm.org, linux-kernel@vger.kernel.org, linville@tuxdriver.com
Subject: Re: 2.6.17-rc1-mm1
Message-Id: <20060405002909.2ab4482b.akpm@osdl.org>
In-Reply-To: <20060405070150.GA10351@k3.hellgate.ch>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<1144187618.26812.7.camel@localhost>
	<20060404150953.41d7e04e.akpm@osdl.org>
	<20060405070150.GA10351@k3.hellgate.ch>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi <rl@hellgate.ch> wrote:
>
> Any suggestions for an elegant solution?

Move the locking down lower, so it just locks the stuff which needs locking?

It all depends on what the lock's role is, and so often that's a big secret.

If the intention is to prevent concurrent execution of mdio_read()
(reasonable) and we really need that 1 msec delay between writing the
registers and reading back the result then we're somewhat screwed.  Either
use a sleeping lock to protect that hardware state or go back to using
udelay().
