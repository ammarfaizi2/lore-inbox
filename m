Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVBRA26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVBRA26 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBRA26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:28:58 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:49625 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261260AbVBRA2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:28:55 -0500
Message-ID: <421536C3.7050903@candelatech.com>
Date: Thu, 17 Feb 2005 16:28:51 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vincent Roqueta <vincent.roqueta@ext.bull.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDP and e1000 : Simple test,  little bugs.
References: <200502151108.46768.vincent.roqueta@ext.bull.net>
In-Reply-To: <200502151108.46768.vincent.roqueta@ext.bull.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Roqueta wrote:
> Hello all,
> 
> I am working on NFS interoperabiity and I experiment some problems with UDP. 
> The problem appear between the linux 2.6.10rc1 and 2.6.10rc2, and is still 
> present in the last kernel (2.6.11rc3)
> 
> With NFSv3:
> Client send a 32k file splited into 22 IP fragments. The problem is the server 
> only receive 17 fragments.
> More investigation tell me that the server reveive 17 fragments because the 
> client only send 17  IP fragments.
> 
> As the NFS client code is exactly the same between the 2.6.10rc1 and 2.6.10rc2 
> I tried to write a simple UDP client server, to be sure there is no relation 
> between this bug and NFS.
> 
> Client create a buffer of X bytes and fill it with the 'A' symbol. Then it 
> write it over a udp socket (sendto).
> Server read the first 1024KB sent.
> 
> If X is <26000 the write is done with sucess.
> Else it fail. (Typicaly for a 32KB size, as for NFS)

Try setting the socket send buffer size larger.  By default it's
quite small, and so it may not accept a large UDP frame.

Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

