Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTJAAEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJAAEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:04:31 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:63697 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S261840AbTJAACG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:02:06 -0400
Subject: Re: 2.6.0-test6: more __init bugs
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Corey Minyard <cminyard@mvista.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F795001.9020104@mvista.com>
References: <1064955628.5734.229.camel@dooby.cs.berkeley.edu> 
	<3F795001.9020104@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Sep 2003 17:02:03 -0700
Message-Id: <1064966523.5734.246.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 02:42, Corey Minyard wrote:
> This is not actually a bug, but it may be bad style (and thus could lead 
> to a bug).  It is possible that something that uses IPMI can do some 
> IPMI things before IPMI is initialized.  This can only happen during 
> initialization, though.  Thus the check; once IPMI is initialized the 
> function will never be called.
> 
> What's the opinion on this?  Should I just force IPMI users to 
> initialize after IPMI?

Thanks for looking at it.  Would it be reasonable to fail if a client
tries to use the ipmi interface before it is initialized?  That would be
a simple change, e.g.:

if (!initialized)
       return -ENODEV;

Best,
Rob


