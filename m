Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUJGS2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUJGS2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUJGS1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:27:30 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:16527 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S267551AbUJGSUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:20:41 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
       "'Jean-Sebastien Trottier'" <jst1@email.com>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'David S. Miller'" <davem@redhat.com>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 11:20:32 -0700
Organization: Cisco Systems
Message-ID: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <41656CD8.9080808@nortelnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This actually sounds quite interesting.
> 
> For applications that are prepared to handle the nonblocking 
> case, you get full speed.  For applications coded to POSIX, 
> you get correctness.
> 
> It does mean that select() is now a bit more complicated, but 
> applications become much easier to write.

It was my original proposal. The only question is to return which error
code. We cannot return EAGAIN as Posix explicitly disallows it. Is EIO good?
Or some other new error code?

As far as implmentation goes, we probably need a "check_data" function in
the f_ops. Default it could be NULL.

The question is that is it worth the trouble to be Posix complaint? Seems
most developers think not, especially since it has been this way for so long
a time.

Hua

