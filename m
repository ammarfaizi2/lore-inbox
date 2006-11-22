Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755578AbWKVJh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbWKVJh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 04:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755589AbWKVJh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 04:37:28 -0500
Received: from server1.secure-linux-server.com ([207.44.172.97]:9966 "EHLO
	server1.secure-linux-server.com") by vger.kernel.org with ESMTP
	id S1755578AbWKVJh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 04:37:27 -0500
Message-ID: <45641A4E.6020505@ufomechanic.net>
Date: Wed, 22 Nov 2006 09:37:18 +0000
From: Amin Azez <azez@ufomechanic.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux.nics@intel.com, Michael.ODonnell@stratus.com,
       jesse.brandeburg@gmail.com
Subject: e100 breakage located
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not subscribed to lkm so please Cc me in any responses.

This may be relevant to a post by jesse.brandeburg@gmail.com who
reported e100 as not working; perhaps if he uses a cross-over cable it
will "work" again.

I notice a patch in 2005 from Micahel O'Donnel to the e100.c driver has
stopped auto-crossover working on some e100 devices we use.

On one system the auto-negotiation was restored by commenting out:
(nic->mac == mac_82551_10) in function e100_phy_init where the MDI/MDI-X
is disabled.

lspci reports:
 01:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 10)
 01:04.0 Class 0200: 8086:1229 (rev 10)

and on another device
 01:05.0 Ethernet controller: Intel Corp. 82559ER (rev 10)
 01:01.0 Class 0200: 8086:1209 (rev 10)

So it is true that we are revision 10, but 82557/9 not 82551.

I must confess that having gotten this far, I am lost. Of course I can
"fix" the driver for our hardware but I am not sure how to contrive a
general fix.

Maybe the actual damage is done in
 e100_get_defaults(struct nic *nic)
where nic->mac is set to nic->rev_id ?

But it generally seems to be a failure to take into account the actual
hardware type, and only consider the revision.

Any ideas?

Sam
