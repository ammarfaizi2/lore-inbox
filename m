Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVGFWFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVGFWFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVGFUJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:09:41 -0400
Received: from gate.corvil.net ([213.94.219.177]:44555 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262170AbVGFSzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:55:33 -0400
Message-ID: <42CC2923.2030709@draigBrady.com>
Date: Wed, 06 Jul 2005 19:55:31 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How do you accurately determine a process' RAM usage?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a tool to report how much RAM a
particular program (apache for e.g.) was using:
http://www.pixelbeat.org/scripts/ps_mem.py

I was then pointed at the following:
http://wiki.apache.org/spamassassin/TopSharedMemoryBug
which describes how copy-on-write pages are
not counted as shared since 2.6.

So how can one determine how much RAM a process is using?
Seems like a fundamental requirement to me.
Could we add a "SharedTotal" column to /proc/$$/statm for e.g. ?

Here's a little python script to demo the problem:

#!/usr/bin/python
import os, sys, time
a="\x00"*(32*1024*1024) #alloc 32MiB
pid=os.fork()
if(not pid):
     time.sleep(1)
     sys.exit()
sizel=map(float,open("/proc/"+str(pid)+"/statm").readlines()[0].split()[1:3])
print "only %.1f%% reported as shared" % ((sizel[1]/sizel[0])*100)
os.wait()

-- 
Pádraig Brady - http://www.pixelbeat.org
--
