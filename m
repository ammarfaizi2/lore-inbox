Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276917AbRJCIlY>; Wed, 3 Oct 2001 04:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276468AbRJCIlQ>; Wed, 3 Oct 2001 04:41:16 -0400
Received: from mel.alcatel.fr ([212.208.74.132]:23221 "EHLO mel.alcatel.fr")
	by vger.kernel.org with ESMTP id <S276072AbRJCIk4>;
	Wed, 3 Oct 2001 04:40:56 -0400
Message-ID: <3BBACF29.7BB980C4@sxb.bsf.alcatel.fr>
Date: Wed, 03 Oct 2001 10:41:14 +0200
From: Pierre PEIFFER <pierre.peiffer@sxb.bsf.alcatel.fr>
X-Mailer: Mozilla 4.78 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: e2compress in kernel 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

    We are willing to port e2compress from 2.2 kernel series to 2.4 and
we are looking for the right way for porting the compression on the
write part.

    For the read operation, we can adapt the original design: the 2.2
part of e2compress can be easily integrated in the 2.4 version; for the
write, it is a little bit more complicated...

    As we understand, in the 2.2 kernel, the compression is integrated
between the page cache and the buffer cache, i.e. data pointed by the
pages remain always uncompressed, but the compression occurs on buffers
=> data pointed by the buffers become compressed when the system decide
to.
    What we also saw is that in 2.2, in ext2_file_write, the writes
occurs on buffers, and after that, the system looks for the
corresponding page, and if it is present, it also update the data in
this page.

    But, under 2.4, as we see in the "generic_file_write", the write
operation occurs on pages, and no more on buffers as in 2.2. And the
needed buffers are created and associated to the page, i.e. the b_data
field of the buffers points on the data of the considered page.

    So, here, we are a little bit confused because we don't know where
to introduce the compression, if we keep the same idea of the 2.2
design... In fact, on one hand, once the buffers will be compressed, the
pages will also become compressed, but on the other hand, we don't want
the pages to be compressed, because, the pages, once registered and
linked to the inode are supposed to be uncompressed...

    So our idea was to introduce the notion of "cluster of pages", as
the notion of cluster of blocks, i.e. performs the write on several
pages at a time, then compress the buffers corresponding to these pages,
but here the data of the buffers should be splitted up from the data of
the pages and that's our problem... We don't know how to do this. Is
there a way to do this ?

    And, from a more general point of view, do you think our approach
has a chance to succeed ?

    If you have any questions, feel free to ask more explainations.

    Thanks,

    Pierre & Denis

PS: Please, cc'ed me personnaly in the answer, I'm not subscribed to the
list.

