Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269473AbUJFUQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269473AbUJFUQY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUJFUOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:14:45 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:3997 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269451AbUJFULF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:11:05 -0400
Message-ID: <4164514F.2040006@nortelnetworks.com>
Date: Wed, 06 Oct 2004 14:10:55 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hzhong@cisco.com
CC: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Joris van Rantwijk'" <joris@eljakim.nl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <003701c4abde$fb251f60$b83147ab@amer.cisco.com>
In-Reply-To: <003701c4abde$fb251f60$b83147ab@amer.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:

>>>How hard is it to treat the next read to the fd as 
>>NON_BLOCKING, even if it's not set?
>>
>>Userspace likely would not properly handle EAGAIN on a 
>>nonblocking socket.

I meant blocking, of course, but you caught that.

> But it's better than blocking the call, isn't it?
> 
> If the caller is using NON_BLOCKING already, no change in behavior,
> otherwise it returns an error which the app may or may not handle, instead
> of blocking it (which is usually fatal). Plus it hopefully gives Posix
> compliance.

 From what Andries posted, we can't block.  If select says its readable, we can 
"return data, an  end-of-file  indication,  or  an  error other than one 
indicating that it is  blocked".

We have no data, network sockets don't have end-of-file indication (or would 
returning a length of zero count?), and there is no other suitable errno that I saw.

> I can see there could be remote DoS attacks by just sending malformed UDP
> packets.

Yep.

Chris
