Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264355AbUFKWDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUFKWDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbUFKWDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 18:03:11 -0400
Received: from as1-1-4.nvik.s.bonet.se ([194.236.255.141]:10133 "EHLO zappa.cx")
	by vger.kernel.org with ESMTP id S264355AbUFKWDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 18:03:00 -0400
Message-ID: <40CA2C12.3060207@zappa.cx>
Date: Sat, 12 Jun 2004 00:02:58 +0200
From: Andreas Sundstrom <sunkan@zappa.cx>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc2 and newer cause trouble with amanda
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-4.9) BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have trouble upgrading from 2.6.5 to 2.6.6, I have narrowed it down by trying the different rc releases. Between 2.6.6-rc1 and 
2.6.6-rc2 something happens that make my amanda backups fail with the error [bad CONNECT response].

If I do nothing else than boot to 2.6.6-rc1 from rc2 it works so it seems to be somthing with the kernel that is causing the 
trouble, but I don't know how to investigate further.

This is the best debug info I've found so far.

Non-working:
root@zappa:/var/tmp/amanda# cat sendbackup.20040511223325.debug
sendbackup: debug 1 pid 2463 ruid 0 euid 0: start at Tue May 11 22:33:25 2004
/usr/lib/amanda/sendbackup: version 2.4.4p2
   parsed request as: program `GNUTAR'
                      disk `/boot'
                      device `/boot'
                      level 1
                      since 2004:5:11:10:6:42
                      options `|;bsd-auth;index;exclude-list=.amanda.excludes;exclude-optional;'
sendbackup: try_socksize: send buffer size is 65536
sendbackup: time 0.003: stream_server: waiting for connection: 0.0.0.0.564
sendbackup: time 0.003: stream_server: waiting for connection: 0.0.0.0.565
sendbackup: time 0.003: stream_server: waiting for connection: 0.0.0.0.566
sendbackup: time 0.008: waiting for connect on 564, then 565, then 566
sendbackup: time 30.003: stream_accept: timeout after 30 seconds
sendbackup: time 30.003: timeout on data port 564
sendbackup: time 59.998: stream_accept: timeout after 30 seconds
sendbackup: time 59.998: timeout on mesg port 565
sendbackup: time 89.994: stream_accept: timeout after 30 seconds
sendbackup: time 89.994: timeout on index port 566
sendbackup: time 89.994: pid 2463 finish time Tue May 11 22:34:55 2004

Working:
root@zappa:/var/tmp/amanda# cat /tmp/amanda/sendbackup.20040611030533.debug
sendbackup: debug 1 pid 26091 ruid 0 euid 0: start at Fri Jun 11 03:05:33 2004
/usr/lib/amanda/sendbackup: version 2.4.4p2
   parsed request as: program `GNUTAR'
                      disk `/boot'
                      device `/boot'
                      level 0
                      since 1970:1:1:0:0:0
                      options `|;bsd-auth;index;exclude-list=.amanda.excludes;exclude-optional;'
sendbackup: try_socksize: send buffer size is 65536
sendbackup: time 0.003: stream_server: waiting for connection: 0.0.0.0.840
sendbackup: time 0.003: stream_server: waiting for connection: 0.0.0.0.841
sendbackup: time 0.003: stream_server: waiting for connection: 0.0.0.0.842
sendbackup: time 0.020: waiting for connect on 840, then 841, then 842
sendbackup: time 0.020: stream_accept: connection from 192.168.20.100.36640
sendbackup: time 0.021: stream_accept: connection from 192.168.20.100.36641
sendbackup: time 0.021: stream_accept: connection from 192.168.20.100.36642
sendbackup: time 0.021: got all connections
sendbackup-gnutar: time 0.023: doing level 0 dump as listed-incremental to /var/lib/amanda/gnutar-lists/zappa.zappa.cx_boot_0.new
sendbackup-gnutar: time 1.495: doing level 0 dump from date: 1970-01-01  0:00:00 GMT
sendbackup: Can't open exclude file '/boot/.amanda.excludes': No such file or directory
sendbackup: time 1.568: spawning /usr/lib/amanda/runtar in pipeline
sendbackup: argument list: gtar --create --file - --directory /boot --one-file-system --listed-incremental 
/var/lib/amanda/gnutar-lists/zappa.zappa.cx_boot_0.new --sparse --ignore-failed-read --totals --exclude-from 
/tmp/amanda/sendbackup._boot.20040611030535.exclude .
sendbackup-gnutar: time 1.589: /usr/lib/amanda/runtar: pid 26361
sendbackup: time 1.589: started index creator: "/bin/tar -tf - 2>/dev/null | sed -e 's/^\.//'"
sendbackup: time 2.754:  53:    size(|): Total bytes written: 10414080 (9.9MB, 8.5MB/s)
sendbackup: time 2.758: index created successfully
sendbackup: time 4.266: pid 26091 finish time Fri Jun 11 03:05:38 2004

Any ideas of how to investigat further? It seems that I'm the only one with this problem beacause I can't find any other posts about 
this. Unfortunately I don't have any other computers with tapedrives on them to try and reproduce the problem (although it seems to 
be about networking so a tapedrive might not be necessary to investigate).

Thanks for any help, I'm not on the list so feel free to CC me if you want a quick answer.

Let me know if I need to post more info, don't want to write a overly large e-mail to no use.
/Andreas Sundstrom
