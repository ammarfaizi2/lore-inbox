Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUHFTuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUHFTuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268267AbUHFTsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:48:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:15844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268265AbUHFTrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:47:52 -0400
Date: Fri, 6 Aug 2004 12:46:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
Message-Id: <20040806124609.3d489a0d.akpm@osdl.org>
In-Reply-To: <4113D977.9040105@lougher.demon.co.uk>
References: <41127371.1000603@lougher.demon.co.uk>
	<4112D6FD.4030707@yahoo.com.au>
	<4112EAAB.8040005@yahoo.com.au>
	<4113B8A2.4050609@lougher.demon.co.uk>
	<4113D4CD.5080109@yahoo.com.au>
	<4113D977.9040105@lougher.demon.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>
> Nick Piggin wrote:
> 
> > No, I suggest you start to code assuming this interface does
> > what it does. I didn't say there is no bug here, but nobody
> > else's filesystem breaks.
> > 
> 
> To stop this silly argument from escalating, I will patch my code.
> 

Well I don't think it's silly.

We are deterministically asking the fs to read a page which lies outside
EOF, and we shouldn't.  If for no other reason than that the ever-popular
"read a million 4k files" workload will consume extra CPU and twice the
pagecache.

