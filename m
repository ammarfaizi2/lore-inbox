Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266717AbTAFOJR>; Mon, 6 Jan 2003 09:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266763AbTAFOJR>; Mon, 6 Jan 2003 09:09:17 -0500
Received: from www.wireboard.com ([216.151.155.101]:52356 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S266717AbTAFOJQ>; Mon, 6 Jan 2003 09:09:16 -0500
To: "Dirk Bull" <dirkbull102@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shmat problem
References: <F175L4BapMJJGizFJ0q0002fff7@hotmail.com>
From: Doug McNaught <doug@mcnaught.org>
Date: 06 Jan 2003 09:17:52 -0500
In-Reply-To: "Dirk Bull"'s message of "Mon, 06 Jan 2003 09:05:37 +0000"
Message-ID: <m37kdiicq7.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dirk Bull" <dirkbull102@hotmail.com> writes:

> I have a problem with the shmat() function. It works correctly when
> one doesn't specify an address where the segment should be attached,
> but fails when one does. To specify an address it must be alligned
> and I did by using  __attribute__ (aligned()). Still the function
> fails. What is the most effective way for a solution
> to this problem.

__attribute__(aligned()) has nothing to do with it--the address needs
to be page-aligned (ie on a multiple of 4K for ix86), unless SHM_RND
is set in the call.  You also need to make sure nothing else is mapped
at the address you're trying to use...

-Doug
