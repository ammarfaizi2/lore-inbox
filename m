Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbUCEOZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbUCEOZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:25:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50122 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262601AbUCEOZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:25:26 -0500
Subject: Re: Is there some bug in ext3 in 2.4.25?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Daniel Fenert <daniel@fenert.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michelle Konzack <linux4michelle@freenet.de>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades>
References: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1078496713.14033.53.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Mar 2004 14:25:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-03-05 at 14:06, Marcelo Tosatti wrote:

> This sounds like memory corruption (which could be caused by a misbehaving
> driver or by flaky hardware) because transaction->t_ilist is not used at
> all by the kernel code. Did this box run stable with other kernels?

Sounds like bad memory to me.  The only other report of this I've seen
was at

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=115935

and that machine didn't pass memtest86.

> Stephen, Andrew, any idea how can transaction->t_ilist become not NULL?

Bad hardware is about the only way I can think of.  If it was a random
kernel memory scribble, you'd expect it to show up in other places too:
the transaction struct is a very very long-lived struct, you wouldn't
expect it to be the only place to show up slab corruptions.

Cheers,
 Stephen

