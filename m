Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUEDOby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUEDOby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 10:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUEDOby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 10:31:54 -0400
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:20799 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264382AbUEDObw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 10:31:52 -0400
Message-ID: <4097A94C.8060403@samwel.tk>
Date: Tue, 04 May 2004 16:31:40 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: nl, en-us, en
MIME-Version: 1.0
To: Libor Vanek <libor@conet.cz>
CC: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos> <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos> <20040504011957.GA20676@Loki>
In-Reply-To: <20040504011957.GA20676@Loki>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Vanek wrote:
> I know that kernel threads work. My question was more like: "I'd
 > like to know, whether writing my module as kernel thread will make
 > it able to read/write files".
[...]
>>> I think there are reasons (speed, speed, speed...)  why some things
 >>> should be done kernel-space.

Using a kernel thread won't improve speed, because to do anything you 
will have to context-switch to the thread. For the stuff you want to do 
you are probably better off having a tiny kernel module to intercept the 
events that you're interested in, notifying a userspace process to do 
the real work. Yes, it will be slower than in kernel space, but only 
slightly. Especially if you use sendfile from the userspace process. And 
it's also good to remember that Linux is optimized for running user 
space processes as fast as possible. :)

--Bart
