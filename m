Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTDZD3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 23:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTDZD3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 23:29:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15277 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263867AbTDZD3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 23:29:40 -0400
Date: Sat, 26 Apr 2003 04:41:51 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Cc: mikem@beardog.cca.cpqcorp.net
Subject: [CFT][PATCH] cciss/cpqarray fixes (2.5)
Message-ID: <20030426034151.GM10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, if you have access to cciss and/or cpqarray test boxen,
please check if ftp.linux.org.uk/pub/people/viro/T24-cciss-C68 and
ftp.linux.org.uk/pub/people/viro/T25-cpqarray-C68 restore the "allow
root to open device with minor 0 even if nothing had been configured"
behaviour.

	Changes:
a) we _always_ register gendisk for disk #0 on controller.
b) it stays registered until we forget about controller.
c) when old code would remove it, we merely set size to 0.

	That (presumably) fixes the breakage introduced in 2.5 when we
started to require registered gendisk for open(2).  Please, check if that
helps and doesn't introduce new breakage - I don't have either hardware, so
it's completely untested.  It builds, but that's it.
