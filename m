Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVHBTd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVHBTd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVHBTd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:33:29 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:60775 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261735AbVHBTd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:33:28 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.95,162,1120428000"; 
   d="scan'208"; a="13504288:sNHT29822596"
Message-ID: <42EFCA87.6090109@fujitsu-siemens.com>
Date: Tue, 02 Aug 2005 21:33:27 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lpfc: system freezing if FC connection is broken under load
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my dual Xeon machine freezes, if connection between
FC switch and tape drives is broken while writing to tapes.

There is one SCSI target with 16 tape LUNs connected to my
FC controller via FC switch. I can reproduce the problem by
starting "dd if=/dev/zero of=/dev/st[0-7] bs=256K" on the
first 8 LUNs. Then I unplug the connection between switch and
tapes.

It doesn't matter if using LP9802 or one channel of LP9402DC.
The problem happens immediately after cfg_nodev_tmo has
run out. If nodev_tmo is changed, time from breaking connection
to machine freezing changes accordingly.

After the problem happened, even NMIs no longer are handled.
I added nmi_watchdog=1 to cmdline and added some simple code
to nmi handler, that writes the nmi counter directly to video ram.
In case of error, nmi no longer counts (but I have no idea, how
this can happen, maybe there is some HW bug).

What could I do to analyze the problem?

Please CC me, I'm not on the list.

Regards
	Bodo
