Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275892AbTHOKbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275894AbTHOKbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:31:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:55718 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275892AbTHOKbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:31:06 -0400
Date: Fri, 15 Aug 2003 14:31:04 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030815103104.GA15288@namesys.com>
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030814084518.GA5454@namesys.com> <20030815121321.49e4cf09.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815121321.49e4cf09.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Aug 15, 2003 at 12:13:21PM +0200, Stephan von Krawczynski wrote:

> there was a question about fsck'ing the ext3 filesystems. Since it crashed
> today I did check them now and no errors or warnings showed up. Everything
> seems clean. I don't exactly understand what that tells you. I guess you mean
> the fs metadata may have been hit, too. Seems not.

Yes. And from what I remember, all the oopses on reiserfs were about some
lists corruptions and this sort of things, so not metadata, but kernel
data was damaged somehow.
And your last oops confirms that.
end_buffer_io_async have the loop running with irqs disabled.
And this loop in your case should only have one iteration (you run with 4k
blocksize, I presume) of gouig thorough one buffer attaching to a page.
Also at least one of the oopses you posted prior to that also had signs of
buffer list corruptions. (may be even two).
So it seems something changes buffer lists under out feet without doing
proper locking.
I am not sure how this relates to data corruption, though.
Ok, at least now there seems to be something definite to look for in changes.

Thank you.

Bye,
    Oleg
