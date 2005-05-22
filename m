Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVEVIo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVEVIo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 04:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVEVIo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 04:44:59 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:54444 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261352AbVEVIo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 04:44:57 -0400
Message-ID: <1116751180.4290454cf0c02@imp2-q.free.fr>
Date: Sun, 22 May 2005 10:39:40 +0200
From: perth.adelaide@free.fr
To: linux-kernel@vger.kernel.org
Subject: Dangerous libata Data Corruption Bug (2.4 & 2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 84.5.75.220
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been setting up software RAID5/6 file servers for the past few month, and I
came accross a data corruption bug using the libata driver : It's not an easy
one to find as I need to copy and copy over data to finally have an error
(usually betwen 150GB to 2TB).

So far, every server using the libata driver I've setup has this bug

Here's the awful script I've been using to find this bug :

"
#!/bin/sh
dd if=/dev/urandom of=/tmp/dummy01 bs=1M count=5120
md5sum /tmp/dummy01 > /tmp/dummy.md5
cd /tmp
while [ 1 = 1 ]
    do
        cp /tmp/dummy01 /tmp/dummy02
        rm /tmp/dummy01
        cp /tmp/dummy02 /tmp/dummy01
        md5sum -cv /tmp/dummy.md5
        echo "1" >> /tmp/mdc
        rm /tmp/dummy02
        echo "Tested over: `cat /tmp/mdc | wc -l`0 GB"
    done
"
