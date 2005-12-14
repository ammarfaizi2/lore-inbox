Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVLNHui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVLNHui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVLNHuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:50:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:44183 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932077AbVLNHuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:50:37 -0500
Message-ID: <439FCECA.3060909@us.ibm.com>
Date: Tue, 13 Dec 2005 23:50:34 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andrea@suse.de, Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 0/6] Critical Page Pool
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the latest version of the Critical Page Pool patches.  Besides
bugfixes, I've removed all the slab cleanup work from the series.  Also,
since one of the main questions about the patch series seems to revolve
around how to appropriately size the pool, I've added some basic statistics
about the critical page pool, viewable by reading
/proc/sys/vm/critical_pages.  The code now exports how many pages were
requested, how many pages are currently in use, and the maximum number of
pages that were ever in use.

The overall purpose of this patch series is to all a system administrator
to reserve a number of pages in a 'critical pool' that is set aside for
situations when the system is 'in emergency'.  It is up to the individual
administrator to determine when his/her system is 'in emergency'.  This is
not meant to (necessarily) anticipate OOM situations, though that is
certainly one possible use.  The purpose this was originally designed for
is to allow the networking code to keep functioning despite the sytem
losing its (potentially networked) swap device, and thus temporarily
putting the system under exreme memory pressure.

Any comments about the code or the overall design are very welcome.
Patches agaist 2.6.15-rc5.

-Matt
