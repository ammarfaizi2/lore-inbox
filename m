Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTH1Isl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbTH1IsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:48:22 -0400
Received: from ip213-185-36-189.laajakaista.mtv3.fi ([213.185.36.189]:60148
	"EHLO oma.irssi.org") by vger.kernel.org with ESMTP id S263832AbTH1Ikh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:40:37 -0400
Subject: Re: Lockless file reading
From: Timo Sirainen <tss@iki.fi>
To: nagendra_tomar@adaptec.com
Cc: Jamie Lokier <jamie@shareable.org>, root@chaos.analogic.com,
       Martin Konold <martin.konold@erfrakon.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0308272353470.13148-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0308272353470.13148-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1062060035.1456.222.camel@hurina>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 11:40:36 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 21:42, Nagendra Singh Tomar wrote:
> Hi,
>     I beleive ur original post was to address the case of a reader reading 
> a file getting *incorrect* data due to the file being written 
> simultaneously by another writer process.

Well, "old" data, which mixed with new data would become incorrect as a
whole.

> Why do u require file locking if there is a *single* writer ?? I don't 
> understand why a 123 written over XXX can result in 1X3. The kernel should 
> take care of this. When the writer process is writing 123 it will first be 
> written to the page cache. The page cache lock will be taken inside the 
> kernel before writing to it, so we know that writing 123 over XXX will be 
> atomic.  Now even when this page is flushed to disk, the page lock would 
> be taken. So I cannot see a possibility of 123 written over XXX being read 
> as 1X3.

That was my original plan, to just rely on such kernel behaviour. I just
don't know if it's such a good idea to rely on that, especially if I
want to keep my program portable. I'll probably fallback to that anyway
if my checksumming ideas won't work.


