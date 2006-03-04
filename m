Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWCDAog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWCDAog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWCDAof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:44:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34463 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751778AbWCDAof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:44:35 -0500
Message-ID: <4408E33E.1080703@ce.jp.nec.com>
Date: Fri, 03 Mar 2006 19:45:50 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
CC: Lars Marowsky-Bree <lmb@suse.de>, akpm@osdl.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 0/6] dm/md sysfs dependency tree (rev.3)
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is an updated version of dm/md sysfs dependency tree patch set.
For example, if dm-0 maps to sda, we'll have following symlinks;
   /sys/block/dm-0/slaves/sda --> /sys/block/sda
   /sys/block/sda/holders/dm-0 --> /sys/block/dm-0

Thanks for Alasdair, Neil and Greg for reviews and comments.
I think the patches get much better shape than before.
I'm happy to hear any other comments for these patches.

Patches included are:

  1. [PATCH 1/6] kobject_add_dir
     Adding kobject_add_dir() function which creates
     a subdirectory for a given kobject.

  2. [PATCH 2/6] add holders/slaves subdirectory to /sys/block
     Creating "slaves" and "holders" directories in /sys/block/<disk>,
     creating "holders" directory under /sys/block/<disk>/<partition>

  3. [PATCH 3/6] bd_claim_by_kobject
     Adding bd_claim_by_kobject() function which takes kobject as
     additional signature of holder device and creates sysfs symlinks
     between holder device and claimed device.
     bd_release_from_kobject() is a counter part of bd_claim_by_kobject.

  4. [PATCH 4/6] bd_claim_by_disk
     Variants which take gendisk instead of kobject
     and do kobject_{get,put}(&gendisk->kobj).

  5. [PATCH 5/6] md to use bd_claim_by_disk
     Use bd_claim_by_disk.

  6. [PATCH 6/6] dm to use bd_claim_by_disk
     Use bd_claim_by_disk.

Patches from 1 to 5 work both on 2.6.16-rc5 and 2.6.16-rc5-mm2.
I hope them to be included in mm if there's no problem.

Patch 6 depends on dm-table-store-md.patch in
http://www.kernel.org/pub/linux/kernel/people/agk/patches/2.6/editing/.
The dm-table-store-md.patch might theoretically require some
locking/release-ordering fixes in dm core which is under
investigation though it's separate issue.

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.
