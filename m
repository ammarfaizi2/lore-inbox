Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVEaH77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVEaH77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVEaH77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:59:59 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:36620 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261340AbVEaH75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:59:57 -0400
Message-ID: <429C1ACD.8070600@aitel.hist.no>
Date: Tue, 31 May 2005 10:05:33 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RAID-5 design bug (or misfeature)
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net>  <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz> <1117454144.2685.174.camel@localhost.localdomain> <Pine.LNX.4.58.0505301759550.6859@artax.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.58.0505301759550.6859@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:

>
>I think that's another problem --- when RAID-5 is operating in degraded
>mode, the machine must not crash or volume will be damaged (sectors
>that were not written may be damaged this way). Did anybody develop some
>method to care about this (i.e. something like journaling on raid)? What
>do hardware RAID controllers do in this situation?
>  
>
Hot spares can keep the degraded time to a minimum.  If you want to
keep the risk to a minimum, unmount the raid fs until it is
resynchronized.  If you need more safety, there is options like raid-6
or mirrors of the entire raid-5 set.

Some hw controllers have a battery-backed cache.  Even a power loss
won't ruin the raid - the io will simply sit in that cache until the
disks become available again.  The io operation that was in effect when
power was lost can then be retried. Not that this saves you from everything,
the fs could be inconsistent anyway due to the os being killed in the
middle of its updates. A journalled fs can help with that though.

Helge Hafting
