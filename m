Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUJTWCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUJTWCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270068AbUJTWCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:02:02 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:40082 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S268884AbUJTWAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:00:55 -0400
Message-ID: <4176E001.1080104@zytor.com>
Date: Wed, 20 Oct 2004 15:00:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <cl6lfq$jlg$1@terminus.zytor.com> <4176DF84.4050401@nortelnetworks.com>
In-Reply-To: <4176DF84.4050401@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> H. Peter Anvin wrote:
> 
>> EIO seems to be The Right Thing[TM]... it pretty much says "yes, we
>> received something, but it was bad."  What isn't clear to me is how
>> applications react to EIO.  It could easily be considered a fatal
>> error... :-/
> 
> 
>  From an application point of view, The Right Thing would be to do the 
> checksum validation at select() time if the socket is blocking.
> 
> If it's nonblocking, then just do as we do now and return EAGAIN at 
> recvmsg() time.
> 
> This would ensure that all existing apps get the expected semantics, but 
> the ones based on blocking sockets would see a performance degredation.
> 

Doing work twice can hardly be considered The Right Thing.

	-hpa
