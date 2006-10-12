Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965281AbWJLFa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbWJLFa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWJLFa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:30:57 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:39393 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965281AbWJLFa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:30:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=MvRrjaEsAWqdPmqT5U6JHlvy4uFTg/Po4xsBh8NuzQOAzuyRRV1K3G95nyKpO/s2HJmhYA/g7tiUbWDUx6+L5B964HgW2XOtnyZed1sjpVBmv7/WqHvINN47+mx0CFxFpPEJOgMUDe98S0mBiRGlxrh+OeCxIVzVdfoJHaiKcu8=
Date: Thu, 12 Oct 2006 14:31:18 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@suse.de>
Subject: [PATCH] md: fix /proc/mdstat refcounting
Message-ID: <20061012053118.GD29465@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen mdadm oops after successfully unloading md module.

This patch privents from unloading md module while
mdadm is polling /proc/mdstat.

Cc: Neil Brown <neilb@suse.de>
Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

Index: work-fault-inject/drivers/md/md.c
===================================================================
--- work-fault-inject.orig/drivers/md/md.c
+++ work-fault-inject/drivers/md/md.c
@@ -4912,6 +4912,7 @@ static unsigned int mdstat_poll(struct f
 }
 
 static struct file_operations md_seq_fops = {
+	.owner		= THIS_MODULE,
 	.open           = md_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
