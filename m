Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758157AbWK0NKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157AbWK0NKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758181AbWK0NKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:10:10 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:61100 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1758157AbWK0NKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:10:09 -0500
Date: Mon, 27 Nov 2006 14:09:53 +0100
To: Andreas Leitgeb <avl@logic.at>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: hpa-problem in ide-disk.c - new insights.
Message-ID: <20061127130953.GA2352@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at> <20061120152505.5d0ba6c5@localhost.localdomain> <20061120165601.GS6851@gamma.logic.tuwien.ac.at> <20061120172812.64837a0a@localhost.localdomain> <20061121115117.GU6851@gamma.logic.tuwien.ac.at> <20061121120614.06073ce8@localhost.localdomain> <20061122105735.GV6851@gamma.logic.tuwien.ac.at> <20061123170557.GY6851@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123170557.GY6851@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears, as if the drive is really approaching breakdown, 
remapping bad sectors and is out of spare sectors. Thus
reducing capacity.   The call to determine the native
sectors seems to still count in those remapped sectors, 
yielding an effectively bogus number.

Perhaps the drive had originally 78165361 sectors, and
(speculating further) the problems only started to show
up, when the "current" sectors dropped down to 78165360,
while the "native" sectors remained at 78165361.

Since I've got no precious data on that disk (anymore),
I'll just watch it, until it suffers the final headcrash.

PS:
It would still be good to be able to turn off hpa-checking
with some module/boot-option to help with any drives that
return effectively wrong "native" capacity (whether they're
actually broken, or might just have a broken firmware).

