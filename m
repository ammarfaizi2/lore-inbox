Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWCACdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWCACdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWCACdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:33:03 -0500
Received: from kanga.kvack.org ([66.96.29.28]:5295 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S964831AbWCACdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:33:01 -0500
Date: Tue, 28 Feb 2006 21:27:51 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Li, Peng" <ringer9cs@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thread safety for epoll/libaio
Message-ID: <20060301022751.GA28899@kvack.org>
References: <598a055d0602281236m7eac9c09oc60af9ce28e7e4bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598a055d0602281236m7eac9c09oc60af9ce28e7e4bf@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 03:36:11PM -0500, Li, Peng wrote:
> I apologize if I should not post this on LKML, but there seems to be
> some lack of documentation for using epoll/AIO with threads.  Are
> these interfaces thread-safe?  Can I use them safely in the following
> way:

I can only speak for libaio, which is completely thread safe.  Having a 
single thread read events and dispatch is likely to work quite well given 
the way the kernel interface is structured internally.  There is still 
room for improving the event mechanism to use a futex for waking so that 
the library can parse multiple events from userspace, but that is pending 
a heavier user like networking.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
