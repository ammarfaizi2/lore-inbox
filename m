Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTENUYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbTENUYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:24:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35486 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262813AbTENUYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:24:18 -0400
Date: Wed, 14 May 2003 13:36:45 -0700 (PDT)
Message-Id: <20030514.133645.35032116.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil>
References: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Wed, 14 May 2003 16:20:09 -0400

   this patch adds a reference count to atm_dev, and a lock to
   protect the members of struct atm_dev.  atm_dev_lock is now
   used to protect the atm_dev linked list.

Nice.  You may wish to try and make it so that atm_dev_lock
can be privatized to one file, using callbacks or something
similar, so that the device list implementation isn't exported
all over the place.

   -	fops_get (dev->ops);
   +	try_module_get(dev->ops->owner);

Use __module_get() in this kind of situation.

Fix this up and resend, thanks.
