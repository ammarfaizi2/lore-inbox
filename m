Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268112AbUHQFQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268112AbUHQFQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 01:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUHQFQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 01:16:46 -0400
Received: from fujitsu2.fujitsu.com ([192.240.0.2]:61653 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S268112AbUHQFQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 01:16:09 -0400
Date: Mon, 16 Aug 2004 22:15:51 -0700
From: Yasunori Goto <ygoto@us.fujitsu.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Lhms-devel] Making hotremovable attribute with memory section[0/4]
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1092702436.21359.3.camel@localhost.localdomain>
References: <1092699350.1822.43.camel@nighthawk> <1092702436.21359.3.camel@localhost.localdomain>
Message-Id: <20040816214017.77A3.YGOTO@us.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> On Maw, 2004-08-17 at 00:35, Dave Hansen wrote:
> > In any case, the question of the day is, does anyone have any
> > suggestions on how to create 2 separate pools for pages: one
> > representing hot-removable pages, and the other pages that may not be
> > removed?
> 
> How do you define the split. There are lots of circumstances where user
> pages can be pinned for a long (near indefinite) period of time and used
> for DMA.

Basically, kernel have to wait of completion of I/O.

> Consider
> - Video capture
> - AGP Gart
> - AGP based framebuffer (intel i8/9xx)

I didn't consider deeply about this, because usually
enterprise server doesn't need Video capture feature or AGP.
It is usually controlled from other machine.

If it is really necessary, kernel might have to wait 
I/O completion or driver modification is necessary.


> - O_DIRECT I/O

I can use page remmaping method by Iwamoto-san.
(See: http://people.valinux.co.jp/~iwamoto/mh.html#remap)
I guess that many case can be saved by this.

> There are also things like cluster interconnects, sendfile and the like
> involved here.

In sendfile case, kernel will wait too. Sooner or later, it will be
timeout.

Thank you for your comment.
Bye.

-- 
Yasunori Goto <ygoto at us.fujitsu.com>


