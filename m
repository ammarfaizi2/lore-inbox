Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270614AbUJUFyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270614AbUJUFyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270437AbUJUFwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:52:40 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:31458 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S270621AbUJUFux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:50:53 -0400
Message-ID: <41774E20.8000309@nortelnetworks.com>
Date: Wed, 20 Oct 2004 23:50:24 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com> <41772674.50403@metaparadigm.com> <417736C0.8040102@zytor.com> <417743EF.90604@nortelnetworks.com> <417744FD.1000008@zytor.com>
In-Reply-To: <417744FD.1000008@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
>> H. Peter Anvin wrote:
>>
>>> The whole point is that it doesn't break the *documented* interface.

> I'm talking about returning -1, EIO.


Ah.  By "it", I thought you meant the current performance optimizations, not the 
EIO.  My apologies.

I think returning EIO is suboptimal, as it is not an expected error value for 
recvmsg().  (It's not listed in the man pages for recvmsg() or ip.)  It would 
certainly work for new apps, but probably not for many existing binaries.

On the other hand, if you simply do the checksum verification at select() time 
for blocking sockets, then the existing binaries get exactly the behaviour they 
expect.

Chris
