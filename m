Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTD2MWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTD2MWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:22:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:42728 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261845AbTD2MWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:22:16 -0400
From: Christian =?iso-8859-1?q?Borntr=E4ger?= <linux@borntraeger.net>
To: acme@conectiva.com.br
Subject: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt show all net devices
Date: Tue, 29 Apr 2003 14:34:18 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304291434.18272.linux@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: /proc/net/devices doesnt show all devices using cat. With dd all are 
available.

I tested a kernels prior to 
http://linus.bkbits.net:8080/linux-2.5/cset@1.797.156.3
and it doesnt seem to have this problem.

If I do a 
& cat /proc/net/dev
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    
packets errs drop fifo colls carrier compressed
    lo:     784      10    0    0    0     0          0         0      784      
dummy0:       0       0    0    0    0     0          0         0        0       
 tunl0:       0       0    0    0    0     0          0         0        0       
  gre0:       0       0    0    0    0     0          0         0        0       
  sit0:       0       0    0    0    0     0          0         0        0       
  eth0: 1078024   19131    0    0    0     0          0         0  5696472   
  eth1:536253967 10078459    0    0    0     0          0         0 3372254868 

I get net devices till eth1, but eth2 and hsi0 are available nevertheless.
but if I do a 

& dd if=/proc/net/dev bs=4096
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    
packets errs drop fifo colls carrier compressed
    lo:    1036      13    0    0    0     0          0         0     1036      
dummy0:       0       0    0    0    0     0          0         0        0       
 tunl0:       0       0    0    0    0     0          0         0        0       
  gre0:       0       0    0    0    0     0          0         0        0       
  sit0:       0       0    0    0    0     0          0         0        0       
  eth0: 1182386   18424    0    0    0     0          0         0 11838659   
  eth1:30499791987 20594094    0    0    0     0          0         0 
  eth2:184353121774 125264473    0    0    0     0          0         0 
  hsi0:123569282529 3827611    0    0    0     0          0         0 
0+1 records in
0+1 records out

All net devices are shown.

cheers

Christian
