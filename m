Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWB0Sat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWB0Sat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWB0Sat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:30:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:2992 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750841AbWB0Sat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:30:49 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH -mm 0/2] mm: shrink_all_memory improvements
Date: Mon, 27 Feb 2006 19:26:19 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271926.20294.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following two patches are designed to improve the shrink_all_memory()
function used by swsusp and other pm functions.

The first patch makes shrink_all_memory() overflow-resistant.  The problem is
that, AFAICT, balance_pgdat(pgdat, nr_to_free, 0) may free more than nr_to_free
pages, in which case nr_to_free, being unsigned, will overflow (and obviously
it cannot be less than 0).  Also if the argument is too big, strange things may
happen.

The first patch adds a workaround of the problem that shrink_all_memory() may
return 0 even if there still are some pages to free.  WIth this patch applied
it sometimes frees 2 times as many pages as without it on my box.

Please have a look and comment.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

