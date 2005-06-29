Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVF2QKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVF2QKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVF2QHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:07:42 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:2359 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S261564AbVF2QGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:06:24 -0400
X-IronPort-AV: i="3.93,242,1115017200"; 
   d="scan'208"; a="284267518:sNHT27005680"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 12/16] IB uverbs: add mthca user PD support
X-Message-Flag: Warning: May contain useful information
References: <2005628163.gtJFW6uLUrGQteys@cisco.com>
	<2005628163.px5sYyzsYWf21dJY@cisco.com>
	<20050628170718.0b2a9cad.akpm@osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 29 Jun 2005 09:06:22 -0700
Message-ID: <52slz1f8qp.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> What is a userspace protection domain?

A protection domain is an abstraction enforced by IB hardware --
loosely put, every resource (work queue, memory region, etc) in put in
a PD when it is created, and different resources can only see each
other if they belong to the same PD.

As an example, PDs are needed because IB allows unprivileged processes
to directly post requests to work queues.  Work requests refer to
memory regions by memory keys (32 bit cookies).  Without PDs, a
process could get access to another process's memory region if it
could guess the 32-bit key -- with PDs, it can't because the other
process's memory region will be in a different PD from its work queue.

 - R.
