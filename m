Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWDKTSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWDKTSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDKTSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:18:12 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:38862 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751070AbWDKTSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:18:11 -0400
Message-ID: <443C03E6.7080202@gentoo.org>
Date: Tue, 11 Apr 2006 20:30:46 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: jheffner@psc.edu
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2.6.17 regression: Very slow net transfer from some hosts
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since sometime after 2.6.16, some websites have been very slow to load. 
  Examples include:

http://zd1211.ath.cx
http://developer.osdl.org/shemminger/blog/
http://www.reactivated.net/weblog

On a good kernel, "wget http://zd1211.ath.cx" says:
20:23:38 (90.44 KB/s) - `index.html' saved [20895/20895]

On a bad kernel:
20:14:18 (327.01 B/s) - `index.html' saved [20895/20895]

I reproduced this on two different internet connections (same ISP 
though). However I cannot reproduce it on my other system.

git-bisect tracked it down to:

7b4f4b5ebceab67ce440a61081a69f0265e17c2a is first bad commit
diff-tree 7b4f4b5ebceab67ce440a61081a69f0265e17c2a (from 
2babf9daae4a3561f3264638a22ac7d0b14a6f52)
Author: John Heffner <jheffner@psc.edu>
Date:   Sat Mar 25 01:34:07 2006 -0800

     [TCP]: Set default max buffers from memory pool size

Indeed, reverting this patch from 2.6.17-rc1-git4 allows those sites to 
load again.

Any ideas?

Thanks,
Daniel
