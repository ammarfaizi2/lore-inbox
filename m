Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbULRTx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbULRTx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 14:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbULRTx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 14:53:59 -0500
Received: from neopsis.com ([213.239.204.14]:40078 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S261223AbULRTx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 14:53:56 -0500
Message-ID: <41C48B3F.8010709@dbservice.com>
Date: Sat, 18 Dec 2004 20:55:43 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Is it possible to access sysfs from within the kernel?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why? Lets see.
Sysfs describes the system with all its devices etc but is also an 
interface to access kernel internal data.
Sysfs data could easily be put into a hierarchical tree. (I think it 
even is, but it's not so obvious, because it's done using the fs code 
(inodes, dentries), maybe the kobjects do play a big role here, too).
To access sysfs from an application, you have to use extensively open() 
and close() for each file (attributes) and readdir for directories... or 
use libsysfs which does these things for you.
While the current design is good for users (cat /sys/.../.../attribute), 
it's not very efficient for applications (due to the many syscalls).
IMO it would be much better (for the applications) to have a device node 
in /dev which could be used to access the sysfs tree. No ioctl but using 
simple packets.
Besides the simple query/result things, you could register for recieving 
events (now hotplug), with the difference that the current hotplug 
(AFAIK) can inform (execute) only one application (/sbin/hotplug).
Or even make it possible to recieve events only from certain 
classes/devices/subsystems etc.

tom
