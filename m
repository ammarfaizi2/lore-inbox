Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269432AbUJFUDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269432AbUJFUDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUJFUAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:00:09 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:1101 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S269419AbUJFT7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:59:35 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Chris Friesen'" <cfriesen@nortelnetworks.com>
Cc: "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Joris van Rantwijk'" <joris@eljakim.nl>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 6 Oct 2004 12:59:25 -0700
Organization: Cisco Systems
Message-ID: <003701c4abde$fb251f60$b83147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <41644D86.4010500@nortelnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hua Zhong wrote:
> 
> > How hard is it to treat the next read to the fd as 
> NON_BLOCKING, even if
> > it's not set?
> 
> Userspace likely would not properly handle EAGAIN on a 
> nonblocking socket.

But it's better than blocking the call, isn't it?

If the caller is using NON_BLOCKING already, no change in behavior,
otherwise it returns an error which the app may or may not handle, instead
of blocking it (which is usually fatal). Plus it hopefully gives Posix
compliance.

I can see there could be remote DoS attacks by just sending malformed UDP
packets.
 
> As far as I can tell, either you block, or you have to scan 
> the checksum before 
> select() returns.
> 
> Would it be so bad to do the checksum before marking the 
> socket readable? 
> Chances are we're going to receive the message "soon" 
> anyways, so there is at 
> least a chance it will stay hot in the cache, no?
> 
> Chris
> 

