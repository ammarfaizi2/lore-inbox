Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVCFSDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVCFSDd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 13:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVCFR7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:59:34 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:42139 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261453AbVCFR5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:57:00 -0500
Subject: Re: [patch] add scsi changer driver
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050216143936.GA23892@bytesex>
References: <20050215164245.GA13352@bytesex>
	 <20050215175431.GA2896@infradead.org>  <20050216143936.GA23892@bytesex>
Content-Type: text/plain
Date: Sun, 06 Mar 2005 19:55:25 +0200
Message-Id: <1110131725.9206.25.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking through this, the only things I really noticed that need work
are:

ch_do_scsi():  It looks like this has an effective reimplementation of
scsi_wait_req.  We're trying to deprecate the usage of scsi_do_req so we
can make it private eventually.  What's the reason you can't use
scsi_wait_req?

ch_ioctl() (and the compat): since this is a new driver, can't this all
be done via sysfs?  That way, the user would be able to manipulate it
from the command line, and we'd no longer need any of the 32->64 compat
glue.

James



