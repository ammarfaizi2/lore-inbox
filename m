Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbUACWkS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264319AbUACWkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:40:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:6321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264314AbUACWkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:40:15 -0500
Date: Sat, 3 Jan 2004 14:40:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paolo Ornati <ornati@lycos.it>
Cc: gandalf@wlug.westbo.se, linuxram@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Message-Id: <20040103144003.07cc10d9.akpm@osdl.org>
In-Reply-To: <200401031213.01353.ornati@lycos.it>
References: <200401021658.41384.ornati@lycos.it>
	<20040102213228.GH1882@matchmail.com>
	<1073082842.824.5.camel@tux.rsn.bth.se>
	<200401031213.01353.ornati@lycos.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati <ornati@lycos.it> wrote:
>
> I know these are only performance in sequential data reads... and real life 
>  is another thing... but I think the author of the patch should be informed 
>  (Ram Pai).

There does seem to be something whacky going on with readahead against
blockdevices.  Perhaps it is related to the soft blocksize.  I've never
been able to reproduce any of this.

Be aware that buffered reads for blockdevs are treated fairly differently
from buffered reads for regular files: they only use lowmem and we always
attach buffer_heads and perform I/O against them.

No effort was made to optimise buffered blockdev reads because it is not
very important and my main interest was in data coherency and filesystem
metadata consistency.

If you observe the same things reading from regular files then that is more
important.

