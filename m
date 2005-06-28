Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVF1LVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVF1LVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVF1LVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:21:07 -0400
Received: from verein.lst.de ([213.95.11.210]:1686 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261308AbVF1LVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:21:06 -0400
Date: Tue, 28 Jun 2005 13:21:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: markus.lidel@shadowconnect.com, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: sysfs abuse in recent i2o changes
Message-ID: <20050628112102.GA1111@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/message/i2o/config-osm.c has a function sysfs_create_fops_file,
which creates a sysfs file with supplied file_operations.  This is
pretty much against the sysfs design which only wants simple attributes,
ascsii or for corner cases binary.

Also, if we're going to allow this code it should move to sysfs.  And
stop using lookup_hash directly (use lookup_one_len instead), it'll go
away soon.
