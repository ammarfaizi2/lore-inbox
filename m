Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbTKETjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbTKETjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:39:18 -0500
Received: from palrel12.hp.com ([156.153.255.237]:60813 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263136AbTKETjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:39:08 -0500
Date: Wed, 5 Nov 2003 11:39:06 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches for 2.6.X
Message-ID: <20031105193906.GA24323@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Dave,

	Here is a set of patches for 2.6.0-test10. As per Linus
requirement, those are only critical bug fixes. The first Oops was
experienced by various people on LKML, the second by me.
        Patches tested on 2.6.0-test9, please push to Linus...

        Thanks...

        Jean

----------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir2609_ircomm_might_sleep-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Martin Diehl>
	o [CRITICA] Don't do copy_from_user() under spinlock
	o [CRITICA] Always access self->skb under spinlock

ir2609_irnet_ppp_open_race-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] Prevent sending status event to dead/kfree sockets
	o [CORRECT] Disable PPP access before deregistration
		PPP deregistration might sleep -> race condition

ir2609_irlmp_open_leak.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Chris Wright>
	o [CORRECT] Prevent 'self' leak on error in irlmp_open.
		ASSERT is compiled in only with DEBUG option => risk = 0.
