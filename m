Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbUJ0PvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbUJ0PvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUJ0PvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:51:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20870 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262449AbUJ0PvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:51:12 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16767.50093.59665.83462@segfault.boston.redhat.com>
Date: Wed, 27 Oct 2004 11:50:05 -0400
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: netpoll_setup questions
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matt,

The section of code in the body of this if statement:

	if (!(ndev->flags & IFF_UP)) {

is a bit broken.  First, upon discussion with jgarzik, it seems we should
not check for IFF_UP, but instead do netif_running.  However, I'm wondering
why we try to force the interface up in the first place?  Just because we
force it up doesn't mean that it will get an IP address.  And, in the case
where it doesn't, you will get an oops further on when dereferencing the
ifa_list.  So, why does this section of code exist at all?  If it has a
good purpose, can we replace it with a call to ndev->open?

Thanks!

Jeff
