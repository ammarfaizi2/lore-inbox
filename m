Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280267AbRJaPbr>; Wed, 31 Oct 2001 10:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280269AbRJaPbh>; Wed, 31 Oct 2001 10:31:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34823 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280267AbRJaPbX>; Wed, 31 Oct 2001 10:31:23 -0500
Date: Wed, 31 Oct 2001 07:28:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: pre6 oom killer oops
In-Reply-To: <3BE00078.FF088117@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110310725330.32330-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Jeff Garzik wrote:
>
> 2.4.14-pre6 on alpha.  three oops attached, an oops right after oom
> killer kicked in, and two hits on this BUG:  kernel BUG at buffer.c:498!

This isn't the oom killer - look more closely at your oops:

	do_wp_page: bogus page at address 2000002dbc0 (page 0xfffffc173ab13b00)
	VM: killing process cc1(29719)

Note the "do_wp_page" message _before_ the VM decided to kill the process.
And the first oops seems to be more of the same: big corruption in the
page tables.

Looks like the oom killer kicked in under extreme memory load, but the
extreme memory load caused something else too.

		Linus

