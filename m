Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288309AbSACUn1>; Thu, 3 Jan 2002 15:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288307AbSACUnS>; Thu, 3 Jan 2002 15:43:18 -0500
Received: from mail.webmaster.com ([216.152.64.131]:18871 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S288305AbSACUnO> convert rfc822-to-8bit; Thu, 3 Jan 2002 15:43:14 -0500
From: David Schwartz <davids@webmaster.com>
To: <malekith@pld.org.pl>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (995) - Registered Version
Date: Thu, 3 Jan 2002 12:43:00 -0800
In-Reply-To: <20020103132252.GB21184@ep09.kernel.pl>
Subject: Re: strange TCP stack behiviour with write()es in pieces
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020103204302.AAA10050@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Jan 2002 14:22:52 +0100, Michal Moskal wrote:

>>    If you can design an algorithm that makes that only two times slower, 
>>then
>> the world will be excited and interested and perhaps that algorithm will
>>replace TCP. But until that time, we're stuck with what we have.

>With negle disabled it works 17/15 times slower, which is much less then
>two. Similary with UNIX domain sockets.

	However, with Nagle disabled, there is no bound to how poor network 
efficiency can be. If you do a single byte write every tenth of a second, you 
will send out a packet for each single byte.

	You can only disable Nagle if you can assume that the application is smart 
enough to do the coalescing. After all, someone has to. Since we're talking 
about an app that can't coalesce, you cannot disable Nagle. (Unless you 
consider it acceptable to send one byte of data in each packet.)

	Again, an application *must* *not* disable Nagle unless it (the app) takes 
responsibility for ensuring that data is sent in large enough chunks to 
ensure network efficiency. So you can disable nagle if you want to, but not 
until *AFTER* you make sure your application coalesces writes.

	DS


