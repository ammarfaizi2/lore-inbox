Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbUBXNsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 08:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbUBXNsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 08:48:53 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:22533 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262018AbUBXNsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 08:48:51 -0500
Subject: [IPSec] connect: Resource temporarily unavailable
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Content-Type: text/plain
Message-Id: <1077630520.799.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 24 Feb 2004 14:48:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using Racoon to manage SAs between two IPv4/IPSec hosts running 2.6
kernels and IPSec in transport mode with mandatory ESP/AH support, the
first packet exchange between both hosts triggers IKE Phase 1 but,
instead of queueing the userspace packet that triggered the IKE exchange
until IKE Phase 2 has ended and the SA has been established, userspace
receives the following errpr:

connect: Resource temporarily unavailable

Any further attempt to exchange packets between both hosts succeeds
after a while, (once the IKE Phase 2 ends and the SA has been correctly
established).

Is this a bug? Shouldn't the kernel queue (hold) userspace packets until
IKE Phase 2 has completed (either successfully or with error)? Why am I
receiving "connect: Resource temporarily unavailable" error when there
is no SA set up?

This is reproducible by either pinging or telnetting the other peer or
the IPSec link. Both hosts are running 2.6.3 kernels and ipsec-tools
0.2.2. Once IKE Phase 2 ends, ping and telnet work with no error and
tcpdump reveals that AH/ESP protocols are being used.

