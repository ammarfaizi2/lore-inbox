Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUJGRXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUJGRXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUJGRW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:22:59 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:53482 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267681AbUJGRWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:22:38 -0400
Message-ID: <41657A61.6030601@nortelnetworks.com>
Date: Thu, 07 Oct 2004 11:18:25 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
CC: Martijn Sipkema <martijn@entmoot.nl>, Adam Heath <doogie@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156929.31753.47.camel@localhost.localdomain> <Pine.LNX.4.58.0410071017300.1194@gradall.private.brainfood.com> <004901c4ac8c$2a14ed70$161b14ac@boromir> <20041007160914.GB26784@mark.mielke.cc>
In-Reply-To: <20041007160914.GB26784@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:

> Isn't it more expensive to allow the
> application to be woken up, and poll using read(), than to just do a
> quick check in the kernel and not tell the application there is data,
> when there really isn't?

The issue is caching.

We have to do a pass over the data to copy it to userspace.  If we do the 
checksum verification then, it's basically free since its already in the cache.

If we do it at select() time, we end up having to do two passes over every 
packet, one to verify the checksum, and one to pass it to userspace.

I agree with you though, it'd be nice to have select() change behaviour based on 
whether the socket is blocking or not.

Chris
