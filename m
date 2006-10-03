Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbWJCRwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbWJCRwZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbWJCRwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:52:25 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:18499 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1030440AbWJCRwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:52:23 -0400
X-IronPort-AV: i="4.09,251,1157353200"; 
   d="scan'208"; a="327709418:sNHT57829792"
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org,
       MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
       Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       shemminger@osdl.org, ak@suse.de, davem@davemloft.net
Subject: Re: The change "PCI: assign ioapic resource at hotplug" breaks my system
X-Message-Flag: Warning: May contain useful information
References: <adar6xqwsuw.fsf@cisco.com> <45225876.1080705@jp.fujitsu.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 03 Oct 2006 10:51:55 -0700
In-Reply-To: <45225876.1080705@jp.fujitsu.com> (Kenji Kaneshige's message of "Tue, 03 Oct 2006 21:32:54 +0900")
Message-ID: <ada3ba5s2x0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Oct 2006 17:51:56.0606 (UTC) FILETIME=[9E31BDE0:01C6E714]
Authentication-Results: sj-dkim-6.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Kenji> The cause of this problem might be an wrong assumption that
    Kenji> the 'start' member of resource structure for ioapic device
    Kenji> has non-zero value if the resources are assigned by
    Kenji> firmware. The 'start' member of ioapic device seems not to
    Kenji> be set even though the resources were actually assigned to
    Kenji> ioapic devices by firmware.

    Kenji> I made a patch to fix this problem against
    Kenji> 2.6.18-git18. This patch checks command register instead of
    Kenji> checking 'start' member to see if the ioapic is already
    Kenji> enabled by firmware. Unfortunately, I don't have any system
    Kenji> to reproduce this problem. Could you please try it and let
    Kenji> me know whether the problem is fixed? If the patch below
    Kenji> fixes the problem, I'll resend it with description and
    Kenji> Signed-off-by.

Yes, applying this patch makes everything work on the same SuperMicro
motherboard that breaks with Linus's current tree.  Assuming this
doesn't break anything else, I think this should go upstream.

Thanks,
  Roland
