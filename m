Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131725AbRCOOJ7>; Thu, 15 Mar 2001 09:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131727AbRCOOJt>; Thu, 15 Mar 2001 09:09:49 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:223 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131725AbRCOOJf>; Thu, 15 Mar 2001 09:09:35 -0500
Message-ID: <3AB0CD57.FB97B4C@uow.edu.au>
Date: Fri, 16 Mar 2001 01:10:31 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt Johnston <lkml4@caifex.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS when switching consoles while closing X.
In-Reply-To: <01031521172400.04174@box.caifex.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Johnston wrote:
> 
> Hi.
> 
> I've had a semi-reproducable oops with the kernel. It happens when I'm
> shutting down X (Xfree86 4.02 cvs), while it is closing all open apps (KDE
> 2.1.1 cvs). I switch to a text console (ctrl-alt-F2 etc), and it crashes
> almost as soon as the text console is there.
> 

Someone is calling console functions from interrupt context.
Unfortunately your backtrace looks wrong.  Could you
please rerun ksymoops and send me the output?  Make
sure you're using the correct System.map (ksymoops -m).

It should be pretty straightforward to fix.  While we're there
we'll do something about do_SAK(), which is acquiring the
tasklist_lock from interrupt context.  For heaven's sake.

-
