Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275658AbTHOCJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 22:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275659AbTHOCJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 22:09:24 -0400
Received: from 69-55-72-141.ppp.netsville.net ([69.55.72.141]:26496 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S275658AbTHOCJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 22:09:21 -0400
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
From: Chris Mason <mason@suse.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, green@namesys.com,
       akpm@osdl.org, andrea@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030814194226.2346dc14.skraw@ithnet.com>
References: <20030814084518.GA5454@namesys.com>
	 <Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain>
	 <20030814194226.2346dc14.skraw@ithnet.com>
Content-Type: text/plain
Message-Id: <1060913337.1493.29.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Aug 2003 22:08:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 13:42, Stephan von Krawczynski wrote:

> Hello Marcelo,
> 
> the system is up and running, currently:
> 
>   7:40pm  up 4 days  2:34,  21 users,  load average: 2.07, 2.10, 2.06
> 
> there is still the verification issue, today I added another 50 GB to the data
> stream, and therefore got additional 3 verification  errors. But this seems to
> have no influence on the stability. Box feels ok, reacts completely normal, no
> strange output in any logs.

Just to second Oleg's messages so far, the verification issues are still
serious, it could be the same kind of memory corruptions that could be
causing crashes on reiserfs, just in a different place.

We need to find out if a specific kernel release is causing these
corruptions.  There are lots of different ways to go about it, I would
suggest a combination of fsx (triggers IO and does verification) and
usemem (sucks down ram) from the ext3 cvs progs.

When you can reliably cause either fsx-linux errors or system hangs in a
short period of time, then we can try different prereleases to find the
offending code.

(download details here: http://www.zipworld.com.au/~akpm/linux/ext3/)

Run 4 or so fsx-linux programs (each to its own file) and use usemem to
put your box into swap.  That should hit it pretty quickly, and any
errors from fsx indicate problems.

-chris


