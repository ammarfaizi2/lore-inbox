Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269464AbUJFUbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269464AbUJFUbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269466AbUJFU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:28:58 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:28274 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S269472AbUJFU0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:26:39 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
       "'David S. Miller'" <davem@davemloft.net>
Cc: <aebr@win.tue.nl>, <joris@eljakim.nl>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 6 Oct 2004 13:26:29 -0700
Organization: Cisco Systems
Message-ID: <003a01c4abe2$c3431ad0$b83147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <4164530F.7020605@nortelnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  From what Andries posted, we can't block.  If select says 
> its readable, we can "return data, an  end-of-file  indication, 
> or  an  error other than one indicating that it is  blocked".

Arrrrgh..I misread it as "or an error indicating that it is blocked"..

So treating it simply as NON_BLOCKING isn't right.

> Hmm...no easy solution then.
> 
> In any case, the current behaviour is not compliant with the 
> POSIX text that Andries posted.  Perhaps this should be 
> documented somewhere?
> Alternately, how about having the recvmsg() call return a 
> zero, and (if appropriate) the length of the name set to zero?  This 
> appears to comply with the man page for recvmsg().

If it's a read, returning zero means end-of-file. Not sure what it means 
when recvmsg returns zero..But is this just the problem of UDP or 
recvmsg? I doubt it.

So I guess the easiest solution is just admit Linux select 
isn't posix compliant.

> Chris

