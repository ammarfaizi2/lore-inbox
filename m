Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVJLHzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVJLHzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 03:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVJLHzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 03:55:04 -0400
Received: from email.boi.at ([62.218.133.50]:42606 "EHLO email.boi.at")
	by vger.kernel.org with ESMTP id S1751345AbVJLHzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 03:55:02 -0400
Message-ID: <434CC144.6000504@boi.at>
Date: Wed, 12 Oct 2005 09:54:44 +0200
From: =?ISO-8859-15?Q?=22Dieter_M=FCller_=28BOI_GmbH=29=22?= 
	<dieter.mueller@boi.at>
Reply-To: boi@boi.at
Organization: BOI GmbH
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: blocking file lock functions (lockf,flock,fcntl) do not return after
 timer signal
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bug description:

flock, lockf, fcntl do not return even after the signal SIGALRM  has 
been raised and the signal handler function has been executed
the functions should return with a return value EWOULDBLOCK as described 
in the man pages


test:

sequence of called functions (start the test in 2 terminal sessions)
1. signal
2. setitimer
3. fopen
4. fileno
5. fcntl with F_WRLCK and F_SETLKW (or flock or lockf)
6. getchar (to keep the lock in the 1st session; now start the 2nd)
in the 2nd session the file lock function (fcntl) will not return


kernel versions:

2.4.18-64GB-SMP
2.4.21psetlvm
2.6.11.4-21.9-default


please reply or CC to mailto:boi@boi.at



Dieter Mueller-Wipperfuerth
BOI GmbH.
Spazgasse 4
4040 Linz
Austria

