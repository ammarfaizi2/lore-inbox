Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVI1Wxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVI1Wxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVI1Wxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:53:54 -0400
Received: from [81.2.110.250] ([81.2.110.250]:10428 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751139AbVI1Wxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:53:53 -0400
Subject: Re: [PATCH 2/3] Add disk hotswap support to libata RESEND #5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Lukasz Kosewski <lkosewsk@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <433AEAAE.2070003@pobox.com>
References: <355e5e5e05092618018840fc3@mail.gmail.com>
	 <433AEAAE.2070003@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Sep 2005 00:20:51 +0100
Message-Id: <1127949651.26686.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For PATA the requirements I'm aware of are

-	Interface for user to say "am about to swap"
-	Interface for user to say "have swapped"
-	Must quiesce both master and slave before swap (or one per cable)
-	Must reset to PIO_SLOW and then recompute modes for both devices
becuse it is possible that changing one changes the other timings
-	The above is true for *unplug* too. A straight unplug may speed up the
other drive!
-	Post hotswap need to reconfigure both drives as if from scratch

