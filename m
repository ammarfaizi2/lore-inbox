Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVBUEBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVBUEBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 23:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVBUEBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 23:01:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261782AbVBUEBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 23:01:07 -0500
Date: Sun, 20 Feb 2005 20:00:59 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: axboe@suse.de
Cc: zaitcev@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Merging fails reading /dev/uba1
Message-ID: <20050220200059.53db7b1e@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens:

I think this question belongs to your domain, but please let me know
if I'm mistaken, so I can pursue this elsewhere.

I encountered a strange performance anomaly. I do the following:

<----- Plug USB key
[root@lembas ~]# time dd if=/dev/uba of=/dev/null bs=10k count=10240
10240+0 records in
10240+0 records out

real    0m22.731s
user    0m0.004s
sys     0m0.345s
[root@lembas ~]#

<----- Remove and replug the USB key
[root@lembas ~]# time dd if=/dev/uba1 of=/dev/null bs=10k count=10240
10240+0 records in
10240+0 records out

real    1m42.622s
user    0m0.005s
sys     0m1.518s
[root@lembas ~]#

So, reading from a partition of the same device is 5 times slower than
reading from the device itself. The question is, why?

To the best of my knowledge, this does not occur with SCSI (usb-storage
and sd or sr). This hints strongly that the ub is not doing something
right, but what that can be?

The ub takes the request processing machinery from Carmel exactly. I am
wondering if Carmel (sx8) exhibits any similar performance anomalies
(cc-ing to Jeff)

Additional information:

[root@lembas ~]# cat /proc/version
Linux version 2.6.11-rc4-lem (zaitcev@lembas) (gcc version 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 Tue Feb 15 23:06:39 PST 2005
[root@lembas ~]# cat /proc/partitions
major minor  #blocks  name

   3     0   39070080 hda
   3     1    5935986 hda1
   3     2    5936017 hda2
   3     3     554242 hda3
   3     4          1 hda4
   3     5   26643771 hda5
 180     0    1024000 uba
 180     1    1023983 uba1
[root@lembas ~]#

Thanks,
-- Pete
