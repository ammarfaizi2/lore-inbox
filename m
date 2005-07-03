Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVGCXh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVGCXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 19:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVGCXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 19:37:28 -0400
Received: from mail.harddata.com ([216.123.194.198]:62090 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S261574AbVGCXhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 19:37:21 -0400
Date: Sun, 3 Jul 2005 17:12:02 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: A "new driver model" and EXPORT_SYMBOL_GPL question
Message-ID: <20050703171202.A7210@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It dawned on me only now that a "new driver model" introduced
in patches from GKH export symbols like that:

EXPORT_SYMBOL_GPL(class_create);
EXPORT_SYMBOL_GPL(class_destroy);

and so on.  The problem is that corresponding old symbols, which
are still present in 2.6.12, were exported

EXPORT_SYMBOL(class_simple_create);
EXPORT_SYMBOL(class_simple_destroy);
....

This creates a problem.  There exist out-of-tree drivers which are
using those symbols and, even if sources are available, are not
licensed GPL for whatever reasons.  No, I am not the author of any
of those so I cannot do very much about re-licensing.  As an effect
a conversion to a "new driver model", even if simple, does not work.
In particular I bumped into that with Myrinet card drivers.

Was a decision to use EXPORT_SYMBOL_GPL deliberate and if yes then
what considerations dictated it, other then the patch author wrote
it that way, and what drivers in question are supposed to use when
this change will show up in the mainline?  It looks that 2.6.13
will do this.

  Thanks,
  Michal
