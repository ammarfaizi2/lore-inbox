Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUIOXRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUIOXRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIOXRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:17:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267767AbUIOXPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:15:46 -0400
Date: Wed, 15 Sep 2004 19:15:18 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@muc.de
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040915231518.GB31909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1095288600.1174.5968.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095288600.1174.5968.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 06:50:00PM -0400, Albert Cahalan wrote:
> Andi Kleen writes:
> 
> > Please CSE "current" manually. It generates
> > much better code on some architectures
> > because the compiler cannot do it for you.
> 
> This looks fixable.
> 
> At the very least, __attribute__((__pure__))
> will apply to your get_current function.
> 
> I think __attribute__((__const__)) will too,
> even though it's technically against the
> documentation. While you do indeed read from
> memory, you don't read from memory that could
> be seen as changing. Nothing done during the
> lifetime of a task will change "current" as
> viewed from within that task.

current will certainly change in schedule (),
so either you'd need to avoid using current
in schedule() and use some other accessor
for the same without such attribute, or
#ifdef the attribute out when compiling sched.c.

	Jakub
