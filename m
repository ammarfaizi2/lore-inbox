Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269881AbUJUGVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269881AbUJUGVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbUJUGVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:21:40 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:62860 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S269881AbUJUGNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:13:14 -0400
Message-ID: <417753AF.9060106@metaparadigm.com>
Date: Thu, 21 Oct 2004 14:14:07 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>,
       "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com> <4176E001.1080104@zytor.com> <41772674.50403@metaparadigm.com> <417736C0.8040102@zytor.com> <417743EF.90604@nortelnetworks.com> <417744FD.1000008@zytor.com> <41774E20.8000309@nortelnetworks.com>
In-Reply-To: <41774E20.8000309@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/04 13:50, Chris Friesen wrote:
> H. Peter Anvin wrote:
> 
>>> H. Peter Anvin wrote:
>>>
>>>> The whole point is that it doesn't break the *documented* interface.
> 
> 
>> I'm talking about returning -1, EIO.
> 
> 
> 
> Ah.  By "it", I thought you meant the current performance optimizations, 
> not the EIO.  My apologies.

Same.

> I think returning EIO is suboptimal, as it is not an expected error 
> value for recvmsg().  (It's not listed in the man pages for recvmsg() or 
> ip.)  It would certainly work for new apps, but probably not for many 
> existing binaries.

Yes, big likelyhood of breaking apps although does give you the
deterministic behaviour of recvmsg not blocking after select.

> On the other hand, if you simply do the checksum verification at 
> select() time for blocking sockets, then the existing binaries get 
> exactly the behaviour they expect.

This would be the best from existing usersapce apps, although i'd much
rather have EIO returned than the current behaviour if that was that
was the only choice (although the offshoot would be the need for patches
to quite a few apps).

~mc
