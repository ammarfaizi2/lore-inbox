Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312076AbSCXMHY>; Sun, 24 Mar 2002 07:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312077AbSCXMHP>; Sun, 24 Mar 2002 07:07:15 -0500
Received: from mout1.freenet.de ([194.97.50.132]:17306 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S312076AbSCXMHC>;
	Sun, 24 Mar 2002 07:07:02 -0500
Message-ID: <3C9DC1F5.6010508@athlon.maya.org>
Date: Sun, 24 Mar 2002 13:09:25 +0100
From: andreas <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020323
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [2.4.18] Security: Process-Killer if machine get's out of memory
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've got a basic question:
Would it be possible to kill only the process which consumes the most 
memory in the last delta t?
Or does somebody have a better idea?


Background:
rsync seems to have problems when it is break off (by an error or by 
CTRL-C). After the break off, rsync eats up all the memory of the 
machine until it is killed by the kernel.
Unfortunately, the kernel didn't kill rsync at first, but too late, so 
that a lot of other, very important processes were killed before.
E.g.:

Mar 24 11:46:05 susi kernel: Out of Memory: Killed process 732 (kdeinit).
Mar 24 11:46:06 susi kernel: Out of Memory: Killed process 734 (kdeinit).
Mar 24 11:46:06 susi kernel: Out of Memory: Killed process 734 (kdeinit).
Mar 24 11:46:21 susi kernel: Out of Memory: Killed process 704 (konsole).
Mar 24 11:46:29 susi kernel: Out of Memory: Killed process 729 (kdeinit).
Mar 24 11:46:35 susi kernel: Out of Memory: Killed process 738 (kdeinit).
Mar 24 11:46:43 susi kernel: Out of Memory: Killed process 576 (kppp).
Mar 24 11:46:49 susi kernel: Out of Memory: Killed process 268 (squid).
Mar 24 11:46:50 susi squid[266]: Squid Parent: child process 268 exited 
due to signal 9
Mar 24 11:46:55 susi squid[266]: Squid Parent: child process 1935 started
Mar 24 11:47:01 susi kernel: Out of Memory: Killed process 700 (ktail).
Mar 24 11:47:08 susi kernel: Out of Memory: Killed process 200 (innd).
Mar 24 11:47:18 susi kernel: Out of Memory: Killed process 214 (httpd).
Mar 24 11:47:24 susi kernel: Out of Memory: Killed process 215 (httpd).
Mar 24 11:47:30 susi kernel: Out of Memory: Killed process 216 (httpd).
Mar 24 11:47:36 susi kernel: Out of Memory: Killed process 217 (httpd).
Mar 24 11:47:42 susi kernel: Out of Memory: Killed process 218 (httpd).
Mar 24 11:47:42 susi kernel: Out of Memory: Killed process 218 (httpd).
Mar 24 11:47:47 susi kernel: Out of Memory: Killed process 266 (squid).
Mar 24 11:47:53 susi kernel: Out of Memory: Killed process 1935 (squid).
Mar 24 11:47:53 susi kernel: Out of Memory: Killed process 1935 (squid).
Mar 24 11:48:03 susi kernel: Out of Memory: Killed process 114 (named).
Mar 24 11:48:03 susi kernel: Out of Memory: Killed process 114 (named).
Mar 24 11:48:12 susi kernel: Out of Memory: Killed process 1936 (httpd).
Mar 24 11:48:12 susi kernel: Out of Memory: Killed process 1936 (httpd).
Mar 24 11:48:17 susi kernel: Out of Memory: Killed process 1937 (httpd).
Mar 24 11:48:17 susi kernel: Out of Memory: Killed process 1937 (httpd).
Mar 24 11:48:22 susi kernel: Out of Memory: Killed process 1939 (httpd).
Mar 24 11:48:22 susi kernel: Out of Memory: Killed process 1939 (httpd).
Mar 24 11:48:27 susi kernel: Out of Memory: Killed process 1938 (httpd).
Mar 24 11:48:27 susi kernel: Out of Memory: Killed process 1938 (httpd).
Mar 24 11:48:33 susi kernel: Out of Memory: Killed process 1940 (httpd).
Mar 24 11:48:33 susi kernel: Out of Memory: Killed process 1940 (httpd).
Mar 24 11:48:40 susi kernel: Out of Memory: Killed process 1941 (httpd).
Mar 24 11:48:40 susi kernel: Out of Memory: Killed process 1941 (httpd).
Mar 24 11:48:44 susi kernel: Out of Memory: Killed process 1942 (httpd).
Mar 24 11:48:44 susi kernel: Out of Memory: Killed process 1942 (httpd).
Mar 24 11:48:50 susi kernel: Out of Memory: Killed process 1943 (httpd).
Mar 24 11:48:55 susi kernel: Out of Memory: Killed process 581 (bash).
Mar 24 11:49:00 susi kernel: Out of Memory: Killed process 1944 (httpd).
Mar 24 11:49:06 susi kernel: Out of Memory: Killed process 923 (rsync).
Mar 24 11:49:06 susi kernel: Out of Memory: Killed process 923 (rsync).
Mar 24 11:49:06 susi kernel: VM: killing process rsync

There could have been killed any other process before the evil-doer is 
removed from the memory.

Fortunately, sshd wasn't killed, so I could restart all the other 
processes again.


rsync is an actual example for the problem, I wrote. This could be any 
other process, eating up the memory. Then, the kernel kills wildly some 
processes until the right process is killed - and the machine is 
probably unavailable meanwhile.


Regards,
Andreas Hartmann

