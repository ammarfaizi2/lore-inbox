Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269443AbUJFT7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269443AbUJFT7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269432AbUJFT4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:56:41 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:63642 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269409AbUJFTzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:55:02 -0400
Message-ID: <41644D86.4010500@nortelnetworks.com>
Date: Wed, 06 Oct 2004 13:54:46 -0600
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
References: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
In-Reply-To: <003301c4abdc$c043f350$b83147ab@amer.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:

> How hard is it to treat the next read to the fd as NON_BLOCKING, even if
> it's not set?

Userspace likely would not properly handle EAGAIN on a nonblocking socket.

As far as I can tell, either you block, or you have to scan the checksum before 
select() returns.

Would it be so bad to do the checksum before marking the socket readable? 
Chances are we're going to receive the message "soon" anyways, so there is at 
least a chance it will stay hot in the cache, no?

Chris
