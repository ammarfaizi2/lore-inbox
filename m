Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbUDEKmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUDEKmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:42:14 -0400
Received: from [151.39.82.11] ([151.39.82.11]:13274 "HELO abbeynet.it")
	by vger.kernel.org with SMTP id S261930AbUDEKmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:42:09 -0400
Message-ID: <407137FD.3040407@abbeynet.it>
Date: Mon, 05 Apr 2004 12:42:05 +0200
From: Marco Fais <marco.fais@abbeynet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; it-IT; rv:1.4.2) Gecko/20040308
X-Accept-Language: it, en, en-us
MIME-Version: 1.0
To: Marco Roeland <marco.roeland@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
References: <406D3E8F.20902@abbeynet.it> <20040402131551.GA10920@localhost> <6.0.0.22.2.20040402163334.02abe7d8@pop.localnet> <20040402150535.GA13340@localhost>
In-Reply-To: <20040402150535.GA13340@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.24.0.7; VDF: 6.24.0.85; host: abbeynet.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Roeland ha scritto:

>>Mmmh, all the servers use an RTL-8139 compatible card, with the same 
>>8139too driver. So this can be the problem.
> Hey, I'm by no means an expert. Suggesting the driver is to blame was
> mostly based on the fact that compiling locally worked, and from a
> remote machine triggered a panick. The rest of your description below
> indicates that it probably *isnt't* the driver.

I was not saying *this is the problem*, just noticing that all the 
systems that show this problem have this network card, while the other 
systems that are working perfectly are using other network hardware 
(e100 driver) :)

>>Ok, next I will test the second network card on the server, just to avoid 
>>the possibility of an hardware failure -- but I have other 4 servers that 
>>show the same behaviour, so I don't think it's caused by faulty hardware.
> If 4 other servers show the same behaviour, and netcatting a lot of data
> doesn't panick the machine, that highly suggests that the network card
> and driver are innocent! I thought only one machine had the problem.

If you read Andrew's message, seems that distcc uses a function that 
trigger the problem -- sendfile() -- so, if netcat doesn't use it, it's 
clear why doesn't panic the kernel.

> Have you tried a local distcc compile, but specifying the host name as
> it's IP address or its real name. Distcc treats 'localhost' differently,
> but if it sees an IP address it will use the network route. As specified

Good test.

Yeah, kernel panic in a few seconds. Using localhost instead, compile 
run perfectly for hours.
So it's definitely an issue related to distcc AND networking (and 
probably interaction between network driver and kernel).

Thank you again for your advice!

