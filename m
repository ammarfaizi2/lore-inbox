Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265532AbUAPOJm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUAPOJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:09:42 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:21252 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265532AbUAPOJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:09:40 -0500
Date: Fri, 16 Jan 2004 14:09:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Prashanth T <prasht@in.ibm.com>
Cc: rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwlock_is_locked undefined for UP systems
Message-ID: <20040116140933.C24102@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Prashanth T <prasht@in.ibm.com>, rml@tech9.net,
	linux-kernel@vger.kernel.org
References: <4007EAE7.2030104@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4007EAE7.2030104@in.ibm.com>; from prasht@in.ibm.com on Fri, Jan 16, 2004 at 07:15:11PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 07:15:11PM +0530, Prashanth T wrote:
> Hi,
>     I had to use rwlock_is_locked( ) with linux2.6 for kdb and noticed that
> this routine to be undefined for UP.  I have attached the patch for 2.6.1
> below to return 0 for rwlock_is_locked( ) on UP systems.
> Please let me know.

we don't implement spin_is_locked on UP either because there's no really
usefull return value.  The lock will never be taken on !SMP && !PREEMPT,
but OTOH it's also not needed, so any assert on will give false results.
And the assert is probably the only thing that the _is_locked routines
could used for sanely.

