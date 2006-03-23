Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWCWP6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWCWP6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWCWP6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:58:39 -0500
Received: from mailer2.psc.edu ([128.182.66.106]:21959 "EHLO mailer2.psc.edu")
	by vger.kernel.org with ESMTP id S932100AbWCWP6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:58:38 -0500
From: John Heffner <jheffner@psc.edu>
Organization: PSC
To: Dan Aloni <da-x@monatomic.org>
Subject: Re: [TCP]: rcvbuf lock when tcp_moderate_rcvbuf enabled
Date: Thu, 23 Mar 2006 10:58:18 -0500
User-Agent: KMail/1.9.1
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, dror@xiv.co.il
References: <20060323090441.GA8502@localdomain>
In-Reply-To: <20060323090441.GA8502@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231058.18719.jheffner@psc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 March 2006 04:04, Dan Aloni wrote:
> Hello,
>
> Below, I've forwarded change from 2.6.16 which I think may causes
> problems for applications that use setsockopt with SO_RCVBUF. We are
> using an implementation of an iSCSI target and according to network
> sniffs it seems that during data transfer the receive window
> unjustifyingly shrinks to a very low size (180 bytes). I can guess
> that the code below indirectly affects the receive window size, but
> I'm not sure how it the logic works here, a clarification could be
> helpful.
>
> It's worth to mention that we have sysctl_tcp_moderate_rcvbuf=1, but
> I don't think it should interfere with applications that request to
> have a fixed receive buffer by the means of setsockopt(). I can also
> tell by experiment that reverting the change below makes the problem
> go away.

It shouldn't, but it used to.  That's exactly what this patch changes (making 
tcp_moderate_rcvbuf *not* override the application's requested buffer size).  
Is it possible the application isn't asking for enough buffer space, and that 
the kernel was just automatically helping it before this patch went in?

  -John
