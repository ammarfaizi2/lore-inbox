Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968272AbWLEPLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968272AbWLEPLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968283AbWLEPLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:11:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968272AbWLEPLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:11:53 -0500
Message-ID: <45758C16.5010905@redhat.com>
Date: Tue, 05 Dec 2006 16:11:18 +0100
From: Milan Broz <mbroz@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: stable@kernel.org, linux-kernel@vger.kernel.org
CC: Alasdair G Kergon <agk@redhat.com>,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH][STABLE 2.6.18] dm snapshot: fix freeing pending exception
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix oops when removing full snapshot
kernel bugzilla bug 7040

If a snapshot became invalid (full) while there is outstanding 
pending_exception, pending_complete() forgets to remove
the corresponding exception from its exception table before freeing it.

Already fixed in 2.6.19.

Signed-off-by: Milan Broz <mbroz@redhat.com>

Index: linux-2.6.18.5/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18.5.orig/drivers/md/dm-snap.c	2006-12-02 01:13:05.000000000 +0100
+++ linux-2.6.18.5/drivers/md/dm-snap.c	2006-12-04 17:55:28.000000000 +0100
@@ -691,6 +691,7 @@ static void pending_complete(struct pend
 
 		free_exception(e);
 
+		remove_exception(&pe->e);
 		error_snapshot_bios(pe);
 		goto out;
 	}


