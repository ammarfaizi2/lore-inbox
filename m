Return-Path: <linux-kernel-owner+w=401wt.eu-S1161225AbXAHLKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161225AbXAHLKE (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbXAHLKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:10:04 -0500
Received: from wx-out-0506.google.com ([66.249.82.233]:56139 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161225AbXAHLKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:10:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OGM0xf2A2MiqCYEy8CjzItpNWrB7gDTvWzz4rD/4jwhqrEdHAIEkzTNvtvxfPYigbHIUZwXA1BncGlovx6mQH2vICsU6prjtiKrUEj/gVTk4XVpzSxI5r0pB4X7cTGfBSY3mAZeX7FTYAEykMGnARFO+gwlGnfd6tw5DziD115g=
Message-ID: <9a8748490701080310n6c879acct594856588b2c0b13@mail.gmail.com>
Date: Mon, 8 Jan 2007 12:10:00 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Amit Choudhary" <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>, "Hua Zhong" <hzhong@gmail.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <810563.91187.qm@web55604.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <84144f020701080000v460a9f3aja9570e72fa457934@mail.gmail.com>
	 <810563.91187.qm@web55604.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/07, Amit Choudhary <amit2030@yahoo.com> wrote:
>
> --- Pekka Enberg <penberg@cs.helsinki.fi> wrote:
>
> > On 1/8/07, Hua Zhong <hzhong@gmail.com> wrote:
> > > > And as I explained, it can result in longer code too. So, why
> > > > keep this value around. Why not re-initialize it to NULL.
> > >
> > > Because initialization increases code size.
> >
> > And it also effectively blocks the slab debugging code from doing its
> > job detecting double-frees.
> >
>
> Man, so you do want someone to set 'x' to NULL after freeing it, so that the slab debugging
> code can catch double frees. If you set it to NULL then double free is harmless.

No, setting the pointer to NULL doesn't make a double free harmless it
just hides a bug. The real fix would be to remove the double free.

If you just set the pointer to NULL and ignore the double free then
you've just bloated the kernel with an extra pointless assignment and
left a kfree() call in the kernel that should not be there.  In my
book that's a bug.
If instead you rework the code to avoid the double free, then you
avoid the pointless NULL assignment and you get rid of a kfree call,
and you also get to review the logic and find the flaw that lead to a
double free in the first place.  A double free is not something we
should just sweep under the carpet and forget about, it's very likely
an indication that some logic is flawed and should be fixed.

This KFREE macro does not belong in the kernel IMHO.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
