Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWAaAw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWAaAw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 19:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWAaAw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 19:52:27 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38601 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964975AbWAaAw0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 19:52:26 -0500
Message-ID: <43DEB4B8.5040607@zytor.com>
Date: Mon, 30 Jan 2006 16:52:08 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
Subject: Exporting which partitions to md-configure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm putting the final touches on kinit, which is the user-space 
replacement (based on klibc) for the whole in-kernel root-mount complex. 
   Pretty much the one thing remaining -- other than lots of testing -- 
is to handle automatically mounted md devices.  In order to do that, 
without adding userspace versions of all the paritition code (which may 
be a future change, but a pretty big one) it would be good if the 
partition flag to auto-configure RAID was available in userspace, 
presumably through sysfs.

Any feeling how best to do that?  My current thinking is to export a 
"flags" entry in addition to the current ones, presumably based on 
"struct parsed_partitions->parts[].flags" (fs/partitions/check.h), which 
seems to be what causes md_autodetect_dev() to be called.

Note that this should be available even if md isn't compiled into the 
kernel, thus making it possible to load md as a module before running 
kinit, or to make the equivalent of the kernel mounting sequence from a 
totally runtime user tool.

	-hpa
