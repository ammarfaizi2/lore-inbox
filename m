Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270420AbTGZWBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270516AbTGZWBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:01:46 -0400
Received: from ossipee.unh.edu ([132.177.137.39]:25485 "EHLO ossipee.unh.edu")
	by vger.kernel.org with ESMTP id S270420AbTGZWBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:01:45 -0400
Date: Sat, 26 Jul 2003 18:16:55 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: [RFC] single return paradigm
Message-ID: <20030726221655.GB1148@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8, required 5,
	BAYES_00, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The "single return" paradigm of drivers/char/vt.c:tioclinux() surprised
me at first glance. But I'm now trying to maintain a patch which adds
probes at entry and exit of functions for performance instrumenting, and
this paradigm is a great help, and on the other hand, maintaining the
patch for drivers/scsi/sg/sg_ioctl() is really a drudgery whenever a
little thing changes or a case is added... I don't know what people from
the linux trace toolkit think of this?

Gcc compiles every function into "one return form" anyway, so there's no
penalty in defining a retval variable, having it assigned, and doing a
break or goto out. I has been said to be of religious concern, but
having this habit keeps tracing patches simple. And if one needs, say, a
spinlock at entry & exit, the work is almost done. One could still have
a second exit for error cases, but no more.

Could this be added to CodingStyle or something?

Regards,
Samuel Thibault
