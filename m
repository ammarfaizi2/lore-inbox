Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162139AbWKPBEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162139AbWKPBEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162140AbWKPBEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:04:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1162139AbWKPBEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:04:35 -0500
Date: Wed, 15 Nov 2006 17:03:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Jeff Garzik <jeff@garzik.org>, "Felix Marti" <felix@chelsio.com>,
       linux-kernel@vger.kernel.org
Subject: Re: driver support for Chelsio T210 10Gb ethernet in 2.6.x
Message-ID: <20061115170320.5078073a@freekitty>
In-Reply-To: <Pine.LNX.4.64.0611141540110.3416@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0611131408010.32659@potato.cts.ucla.edu>
	<455A49D7.4050106@garzik.org>
	<20061114153725.730fcd6d@freekitty>
	<Pine.LNX.4.64.0611141540110.3416@potato.cts.ucla.edu>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I took the latest Chelsio driver and gave it a TOE lobotomy so here
is a version to test, it is large so see git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/chelsio-2.6.git

This is a clone of jeff's netdev-2.6 tree, and the chelsio stuff is on
the chelsio branch.

This took me an afternoon, so I don't see why Chelsio didn't do it.

    Port of Chelsio's 2.2.0 version driver from:
        http://service.chelsio.com/drivers/linux/t210/cxgb2toe-2.2.0.tar.gz
    
    De-vendorized:
        - removed all TCP Offload Engine support because those changes
          will not be accepted in mainline kernel.
        - new files run through Lindent
        - removed code that was '#ifdef' for older kernel versions
        - fix for 2.6.19 irq
        - replace usage of TSC with ktime
        - remove /proc trace debug stuff
        - remove dead code
        - incorporate GSO, etc.
        - get rid of FILE_IDENT() macro
        - fix sparse warnings by adding __iomem and __user
