Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263763AbUFNSb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUFNSb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUFNSb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:31:58 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1535 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263763AbUFNSbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:31:46 -0400
Message-ID: <40CDEECF.7060102@nortelnetworks.com>
Date: Mon, 14 Jun 2004 14:30:39 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfltc@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: upcalls from kernel code to user space daemons
References: <1087236468.10367.27.camel@stevef95.austin.ibm.com>
In-Reply-To: <1087236468.10367.27.camel@stevef95.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:
> Is there a good terse example of an upcall from a kernel module (such as
> filesystem) to an optional user space helper daemon?   The NFS RPC
> example seems more complicated than what I would like as does the
> captive ioctl approach which I see in a few places.
> 
> I simply need to poke a userspace daemon (e.g. launched by mount) to do
> in userspace these two optional functions which are not available in
> kernel and pass a small (under 64K) amount of data back to the kernel
> module:
> 1) getHostByName:  when the kernel cifs code detects a server crashes
> and fails reconnecting the socket and the kernel code wants to see if
> the hostname now has a new ip address.
> 2) package a kerberos ticket ala RFC2478 (SPNEGO)

One way to do it (or is this what you meant by captive ioctl?)

userspace daemon loops on ioctl()
kernel portion of ioctl call goes to sleep until something to do
when needed, fill in data and return to userspace
userspace does stuff, then passes data back down via ioctl()
ioctl() puts userspace back to sleep and continues on with other work

Chris
