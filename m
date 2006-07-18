Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWGRCYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWGRCYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 22:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWGRCYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 22:24:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:3218 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751090AbWGRCYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 22:24:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HFiRnsa22A4ouIRHvXuo5ZvQXKEXYVHLi4u92WghWDNX/LnyQLPqCCuaIqTm3TfZ+Tj7ABeaLHSD7MYVGKcWmtEY4SULUXf+nDt4mIizyAKl1pCgJ2Cn7zScpYxEwgVz+BMcUDGPymdHDJ4jv5ROIxTjFaUSPLvHUMyUGayzIMY=
Message-ID: <bda6d13a0607171924v5cd15811v7c9749ad481b232d@mail.gmail.com>
Date: Mon, 17 Jul 2006 19:24:53 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to explain to lock validator: locking inodes in inode order
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code does this:

/* Lock two items. See locking.txt */
static inline void kb0_lock2m(struct kb0_idata *m1, struct kb0_idata *m2)
{
        if (m1->vi.i_ino > m2->vi.i_ino)
                mutex_lock(&m2->k_mutex);
        mutex_lock(&m1->k_mutex);
        if (m1->vi.i_ino < m2->vi.i_ino)
                mutex_lock(&m2->k_mutex);
}

Not sure how to explain to the lock validator that this code can never deadlock.

Note struct kb0_idata has an element of struct inode called vi.
