Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267585AbSLRXnP>; Wed, 18 Dec 2002 18:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267586AbSLRXnO>; Wed, 18 Dec 2002 18:43:14 -0500
Received: from server.ehost4u.biz ([209.51.155.18]:49068 "EHLO
	host.ehost4u.biz") by vger.kernel.org with ESMTP id <S267585AbSLRXnM>;
	Wed, 18 Dec 2002 18:43:12 -0500
Message-ID: <1040255473.3e0109f183d7e@209.51.155.18>
Date: Wed, 18 Dec 2002 18:51:13 -0500
From: billyrose@billyrose.net
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 65.132.64.67
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.ehost4u.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32001 32001] / [32001 32001]
X-AntiAbuse: Sender Address Domain - host.ehost4u.biz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> The number of CPU clocks necessary to make the 'far' or
> full-pointer call by pushing the segment register, the offset,
> then issuing a 'lret' is 33 clocks on a Pentium II.
>
> longcall clocks = 46
> call clocks = 13
> actual full-pointer call clocks = 33

this is not correct. the assumed target (of a _far_ call) would issue a far 
return and only an offset would be left on the stack to return to (oops). the 
code segment of the orginal caller needs pushed to create the seg:off pair and 
hence a far return would land back at the original calling routine. this is a 
very convoluted method of making the orginal call being far, as simply calling 
far in the first pace should issue much faster. OTOH, if you are making a 
workaround to an already existing piece of code, this works beautifully (with 
the additional seg pushed on the stack).

b.
