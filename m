Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132752AbRDXWPz>; Tue, 24 Apr 2001 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRDXWPq>; Tue, 24 Apr 2001 18:15:46 -0400
Received: from 72-ZARA-X13.libre.retevision.es ([62.82.224.72]:43268 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S132752AbRDXWPi>;
	Tue, 24 Apr 2001 18:15:38 -0400
Message-ID: <3AE5953F.2090500@zaralinux.com>
Date: Tue, 24 Apr 2001 17:01:19 +0200
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac12 i586; en-US; 0.8) Gecko/20010226
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Xiong Zhao <xz@gatekeeper.ncic.ac.cn>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: how does linux support domino?
In-Reply-To: <77457B80127E.AAA4AA2@gatekeeper.ncic.ac.cn>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xiong Zhao wrote:

> hello.on linux we will see a new domino server process/thread is created for each
> client.how does linux do this?does it use pthread?using fork or clone or someway 
> else?what's the common way of linux to support apps like lotus domino that will
> have lots of concurrent users which are served by seperate server process/thread?
> regards
> 
> james

Well, in Linux there is no separate concept of threads, so each thread
is a separate process with it's own PID and the PPID of the main thread.
In fact pthread_create() sits just on top of clone().

The way each program handles multiple conections is up to the program,
for example apache 1.3 and below does a fork(), mozilla does a
pthread_create(), BOA does a select() in only one process, and apache
2.0 and up does both a fork() and pthread_create().

-- 
Jorge Nerin
<comandante@zaralinux.com>


