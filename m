Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265321AbSLSOcb>; Thu, 19 Dec 2002 09:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbSLSOcb>; Thu, 19 Dec 2002 09:32:31 -0500
Received: from server.ehost4u.biz ([209.51.155.18]:27569 "EHLO
	host.ehost4u.biz") by vger.kernel.org with ESMTP id <S265321AbSLSOcb>;
	Thu, 19 Dec 2002 09:32:31 -0500
Message-ID: <1040308834.3e01da62a8761@209.51.155.18>
Date: Thu, 19 Dec 2002 09:40:34 -0500
From: billyrose@billyrose.net
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 65.132.64.69
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.ehost4u.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32001] / [32001 32001]
X-AntiAbuse: Sender Address Domain - host.ehost4u.biz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> The target, i.e., the label 'goto' would be the reserved page for the
> system call. The whole purpose was to minimize the number of CPU cycles
> necessary to call 0xfffff000 and return. The system call does not have
> issue a 'far' return, it can do anything it requires. The page at
> 0xfffff000 is mapped into every process and is in that process CS space
> already.

that being the case, why push %cs and reload it without reason as the
code is mapped into every process?

therefore, would it not suffice to use:

        ...
        long_call(); //call to $0xfffff000 via near ret
        //code at $0xfffff000 returns directly here when a ret is issued
        ...

long_call:
        pushl $0xfffff000
        ret

