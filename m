Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267814AbUHERMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267814AbUHERMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267817AbUHERMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:12:05 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:16287 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S267821AbUHERLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:11:00 -0400
Date: Thu, 5 Aug 2004 19:10:49 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040805171049.GA13035@k3.hellgate.ch>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I really wanted /proc/pid/statm to die [1] and I still believe the
reasoning is valid. As it doesn't look like that is going to happen,
though, I offer this fix for the respective documentation.
Note: lrs/drs fields are switched.

Roger

[1] http://marc.theaimsgroup.com/?l=linux-mm&m=106059260315203

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- 2.6-mm/Documentation/filesystems/proc.txt.orig	2004-08-05 16:06:47.000000000 +0200
+++ 2.6-mm/Documentation/filesystems/proc.txt	2004-08-05 19:01:50.943888417 +0200
@@ -169,16 +169,18 @@ information. The  statm  file  contains 
 process memory usage. Its seven fields are explained in Table 1-2.
 
 
-Table 1-2: Contents of the statm files 
+Table 1-2: Contents of the statm files (as of 2.6.8-rc3)
 ..............................................................................
- File     Content                         
- size     total program size              
- resident size of memory portions         
- shared   number of pages that are shared 
- trs      number of pages that are 'code' 
- drs      number of pages of data/stack   
- lrs      number of pages of library      
- dt       number of dirty pages           
+ Field    Content
+ size     total program size (pages)		(same as VmSize in status)
+ resident size of memory portions (pages)	(same as VmRSS in status)
+ shared   number of pages that are shared	(i.e. backed by a file)
+ trs      number of pages that are 'code'	(not including libs; broken,
+							includes data segment)
+ lrs      number of pages of library		(always 0 on 2.6)
+ drs      number of pages of data/stack		(including libs; broken,
+							includes library text)
+ dt       number of dirty pages			(always 0 on 2.6)
 ..............................................................................
 
 1.2 Kernel data
