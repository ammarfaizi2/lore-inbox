Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWGFPQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWGFPQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbWGFPQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:16:05 -0400
Received: from k2smtpout01-02.prod.mesa1.secureserver.net ([64.202.189.89]:11997
	"HELO k2smtpout01-01.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1030305AbWGFPQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:16:04 -0400
X-Antivirus-MYDOMAIN-Mail-From: razvan.g@plutohome.com via plutohome.com.secureserver.net
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:0(82.77.255.201):SA:0(-2.4/5.0):. Processed in 2.455546 secs Process 1517)
Message-ID: <44AD292E.6040100@plutohome.com>
Date: Thu, 06 Jul 2006 18:15:58 +0300
From: Razvan Gavril <razvan.g@plutohome.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] NFS with multiple clients connected
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a nfs server(kernel-server) which i use as a boot server for 
several other machines on the network. Starting with 2.6.16 i started 
noticing that when having more than one of the clients doing a lot of 
in/out on their mounted nfs shares at list one of then starts to to have 
problems when writing (don't know about reading) files. For example dpkg 
writes strange things it the /var/lib/dpkg/status file even if it worked 
perfectly before the kernel upgrade.

Every time an diskless computer fails to write corectly to the nfs 
filesystem i got this messages on the nfs server (dmesg):

RPC: bad TCP reclen 0x3c390000 (large)
RPC: bad TCP reclen 0x31006261 (non-terminal)
RPC: bad TCP reclen 0x73752070 (non-terminal)
RPC: bad TCP reclen 0x52610100 (non-terminal)

Is very simple to spot this behaver (1 write-error for client / 1 rpc 
message in server's dmesg) because apt-get is always giving an error 
message when the /var/lib/dpkg/status file contains something that it 
shouldn't. An it also can be very ease to reproduce.

I tested with 2.6.17 and got the same error, although when using 2.6.15 
didn't got any errors and the clients worked perfect. Since i'm kind of 
forced to use a kernel version > 2.6.15 i really, really need to solve 
this bug. I would be glad to do it myself but i don't have the knowledge 
to do it so if is anybody that can help i can offer all the information 
that i could and also access to a system so he can track the problem.


--
Razvan Gavril



