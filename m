Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268706AbUIQLo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268706AbUIQLo4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268709AbUIQLo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:44:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3720 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268706AbUIQLot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:44:49 -0400
Date: Fri, 17 Sep 2004 12:44:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Stelian Pop <stelian@popies.net>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <20040917102413.GA3089@crusoe.alcove-fr>
Message-ID: <Pine.LNX.4.44.0409171228240.4678-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004, Stelian Pop wrote:
> 	- if the fifo becomes empty after a get() sets in = out = 0
> 	  so only a memcpy() will be needed not two in the next put/get.

Within the lockless __kfifo_get?  Doesn't that violate an essential
property of such a circular buffer, that the producer manipulates
only the "in" index and the consumer only the "out" index?
Within the locking version's kfifo_get wrapper, perhaps.

Hugh

