Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUJGRD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUJGRD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUJGRBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:01:41 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:15824 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267431AbUJGQUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:20:49 -0400
Message-ID: <41656CD8.9080808@nortelnetworks.com>
Date: Thu, 07 Oct 2004 10:20:40 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean-Sebastien Trottier <jst1@email.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net> <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org> <4164EBF1.3000802@nortelnetworks.com> <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> <001601c4ac72$19932760$161b14ac@boromir> <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org> <001c01c4ac76$fb9fd190$161b14ac@boromir> <Pine.LNX.4.61.0410071432070.304@hibernia.jakma.org> <20041007150155.GA2704@mc>
In-Reply-To: <20041007150155.GA2704@mc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Sebastien Trottier wrote:
> Just an outsider's view of someone that has been following this thread:
> 
> Could select() have 2 different behaviors depending on wether the
> O_NONBLOCK flag is set or not on the socket.
> 
> 1. If O_NONBLOCK is set, it can immediately return that the socket is
> ready to be read

> 2. In the case where O_NONBLOCK is not set, select() could wait for all
> the checks to be done before deciding to return or not. In this case the
> meaning would be "there is data ready", NOT "there *might* be data
> ready".

This actually sounds quite interesting.

For applications that are prepared to handle the nonblocking case, you get full 
speed.  For applications coded to POSIX, you get correctness.

It does mean that select() is now a bit more complicated, but applications 
become much easier to write.

Chris

