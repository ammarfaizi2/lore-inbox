Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWFUTsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWFUTsT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWFUTsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:48:18 -0400
Received: from rrcs-24-227-247-53.sw.biz.rr.com ([24.227.247.53]:65164 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S932498AbWFUTsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:48:17 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 0/2][RFC] Network Event Notifier Mechanism
Date: Wed, 21 Jun 2006 14:48:16 -0500
To: swise@opengridcomputing.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Message-Id: <20060621194816.4507.4090.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements a mechanism that allows interested clients to
register for notification of certain network events. The intended use
is to allow RDMA devices (linux/drivers/infiniband) to be notified of
neighbour updates, ICMP redirects, path MTU changes, and route changes.

The reason these devices need update events is because they typically
cache this information in hardware and need to be notified when this
information has been updated.

This approach is one of many possibilities and may be preferred because it
uses an existing notification mechanism that has precedent in the stack.
An alternative would be to add a netdev method to notify affect devices
of these events.

This code does not yet implement path MTU change because the number of
places in which this value is updated is large and if this mechanism
seems reasonable, it would be probably be best to funnel these updates
through a single function.

We would like to get this or similar functionality included in 2.6.19
and request comments.

This patchset consists of 2 patches:

1) New files implementing the Network Event Notifier
2) Core network changes to generate network event notifications

Signed-off-by: Tom Tucker <tom@opengridcomputing.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
