Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269903AbUJTWAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269903AbUJTWAm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268884AbUJTWAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:00:38 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:742 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269903AbUJTV6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:58:53 -0400
Message-ID: <4176DF84.4050401@nortelnetworks.com>
Date: Wed, 20 Oct 2004 15:58:28 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com>
In-Reply-To: <cl6lfq$jlg$1@terminus.zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> EIO seems to be The Right Thing[TM]... it pretty much says "yes, we
> received something, but it was bad."  What isn't clear to me is how
> applications react to EIO.  It could easily be considered a fatal
> error... :-/

 From an application point of view, The Right Thing would be to do the checksum 
validation at select() time if the socket is blocking.

If it's nonblocking, then just do as we do now and return EAGAIN at recvmsg() time.

This would ensure that all existing apps get the expected semantics, but the 
ones based on blocking sockets would see a performance degredation.

Chris
