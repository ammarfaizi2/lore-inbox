Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVKUP5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVKUP5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVKUP5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 10:57:08 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:15113 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932336AbVKUP5G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 10:57:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D4of7cRSGOquZUAJrPlUj6wMdpKbcdMD1gXWayCoZEd/4+UThhY2K8+s0dAhRkQNf1BSjHflo6nwdsyxq40QNBwPuZxqA47pSHZD1pWO9tjI3uQEPAMy7PoA/pXRjA7VU4LFABVCIj6zrwYgUudIjgGvHrPVw0HvIdk0Bfx6Dgc=
Message-ID: <afcef88a0511210757y4fdb8c57w221b0fc9e7ee3ee4@mail.gmail.com>
Date: Mon, 21 Nov 2005 09:57:05 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 6/12: eCryptfs] Superblock operations
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <84144f020511190250x2efdbfb4vf33245b3f7216fe5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041910.GF15747@sshock.rn.byu.edu>
	 <84144f020511190250x2efdbfb4vf33245b3f7216fe5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > +/**
> > + * This is called through iput_final().
> > + * This is function will replace generic_drop_inode. The end result of which
> > + * is we are skipping the check in inode->i_nlink, which we do not use.
> > + */
> > +static void ecryptfs_drop_inode(struct inode *inode) {
> > +       generic_delete_inode(inode);
> > +}
>
> Please drop this useless wrapper and introduce it when it actually
> does something.

It does do something. By providing this function, we over-ride the
default flow of execution.

If we did not provide this function, the flow would be the following:

iput_final -> generic_drop_inode -> generic_delete_inode (or
generic_forget_inode).

However, since we do not care about the i_nlink value, which
generic_drop_inode checks in order to call generic_delete_inode, we
simply circumvent the check by redirecting the flow thusly:

iput_final -> ecryptfs_drop_inode -> generic_delete_inode

I don't see a problem with doing that, but perhaps there is? Please
elaborate if so.

>
>                            Pekka
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
