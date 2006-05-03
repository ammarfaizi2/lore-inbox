Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWECVz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWECVz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWECVz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:55:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:3978 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751370AbWECVz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:55:28 -0400
Date: Wed, 3 May 2006 16:55:23 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Pat Gefre <pfg@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] 2.6 Altix : correct ioc3 port order
In-Reply-To: <200604281931.k3SJVBjR063404@fsgi900.americas.sgi.com>
Message-ID: <20060503165402.E59683@chenjesu.americas.sgi.com>
References: <200604281931.k3SJVBjR063404@fsgi900.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2006, Pat Gefre wrote:

> Currently loading the ioc3 as a module will cause the ports to be
> numbered in reverse order. This mod maintains the proper order of cards
> for port numbering.

Here's the corresponding patch for IOC4.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

diff --git a/drivers/sn/ioc4.c b/drivers/sn/ioc4.c
index 67140a5..cdeff90 100644
--- a/drivers/sn/ioc4.c
+++ b/drivers/sn/ioc4.c
@@ -310,7 +310,7 @@ ioc4_probe(struct pci_dev *pdev, const s
        pci_set_drvdata(idd->idd_pdev, idd);

        mutex_lock(&ioc4_mutex);
-       list_add(&idd->idd_list, &ioc4_devices);
+       list_add_tail(&idd->idd_list, &ioc4_devices);

        /* Add this IOC4 to all submodules */
        list_for_each_entry(is, &ioc4_submodules, is_list) {

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
