Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUBYQ4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbUBYQ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:56:30 -0500
Received: from gw.fs-cfc.co.uk ([193.203.83.22]:7383 "HELO gw.fs-cfc.co.uk")
	by vger.kernel.org with SMTP id S261419AbUBYQ43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:56:29 -0500
Message-ID: <403CD391.1010809@framestore-cfc.com>
Date: Wed, 25 Feb 2004 16:55:45 +0000
From: Johan van den Dorpe <johan.vandendorpe@framestore-cfc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfsd: terminating on error 104 problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

We are currently using quite a number of HP DL380 servers within our 
company that use the 2.4.25 kernel. These are primarily used for heavy 
NFS access, so we keep a large number of nfsd processes concurrently 
running. We have noticed over time however that nfsd processes 
periodically die. From inspection of the system logs, we get numerous 
entries:

Feb 22 12:25:24 ps29 kernel: nfsd: recvfrom returned errno 104
Feb 22 12:25:24 ps29 kernel: nfsd: terminating on error 104

At the moment we cron a script that counts the number of nfsds and 
restart rpc.nfsd if they drop below a threshold. Although this is a 
working solution, it's not ideal and we would really like to get his 
problem patched up properly.

So from my limited knowledge of the kernel source I can see that 
"terminating on error 104" corresponds to line 221 of
/usr/src/linux-2.4.25/fs/nfsd/nfssvc.c. So svc_recv on line 191 is 
obviously returning -104.

I've noticed that in the 2.6.0 kernel there are quite a few changes to 
nfssvc.c, and I wondered if they dealt with this situation.

In the mean time, are there any quick hacks I could add to nfssvc.c to 
make it tolerate error -104? Could I safely alter the main request loop 
to simply continue execution if svc_recv returns this code?

Any help would be much appreciated.

many thanks

-- 
Johan van den Dorpe
