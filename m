Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbUBYUj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUBYUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:39:56 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:15315 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261431AbUBYUjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:39:53 -0500
Date: Wed, 25 Feb 2004 21:39:32 +0100
From: Christophe Saout <christophe@saout.de>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225203920.GA1816@leto.cs.pocnet.net>
References: <1077655754.14858.0.camel@leto.cs.pocnet.net> <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net> <20040225155121.GA7148@leto.cs.pocnet.net> <20040225154453.GB4218@certainkey.com> <20040225181540.GB8983@leto.cs.pocnet.net> <20040225201216.GA6799@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225201216.GA6799@certainkey.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 03:12:16PM -0500, Jean-Luc Cooke wrote:

> Here is the scatterlist+"Le Patch de Christophe":
>   http://jlcooke.ca/lkml/cryptowalk_christophe_25feb2004.patch

Andrew hat another idea that would be even shorter. I don't know if
it's much cleaner though. Trying to implement it.

> Reguarding dm-crypt:
>  I didn't get a response back when suggesting we store IV and MAC info for
>  each block.

Yes, sorry, it's on my todo list (but I kept pushing it back because
explaining the problems in detail would have taken a lot of time). ;)

>  Can we do this?

It's very non-trivial. Think about journalling filesystems, write
ordering and atomicity. If the system crashes between two write
operations we must be able to still correctly read the data. And
write to these "crypto info blocks" should be done in a ways that
doesn't kill performance. Do you have a proposal?

It would make dm-crypt *a lot more* complicated. We need caches
for the info blocks, etc...

>  Can I do this?  Where's the source, in
>  2.3.6-main?

Which source? dm-crypt? In 2.6.3-bk and 2.6.3-mm*. Andrew's latest
tree also has my first "more secure IV proposal" patch in it and I
posted a (broken, racy) hmac IV patch in the other thread.
