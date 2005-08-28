Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVH1Vna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVH1Vna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVH1Vn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:43:29 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:54907 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750843AbVH1Vn2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:43:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A51U6ea488bRv9S9BDK0ZZPgrRunNPjIF2uAlsMtmUw/9tJNEVMKQX6qQM5gyvAWKOaLOzisBCecTajgKjh7OxtoDF84yGE0WOhY3WgPN2m2n9zQIt91dTeiq5kQsdLfbxGYXvL9jPl0immeuN/rltimYoBkfqmP1z3DqVmoc1o=
Message-ID: <a4e6962a05082814433c4618c6@mail.gmail.com>
Date: Sun, 28 Aug 2005 16:43:27 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2.6.13-rc6-mm2] v9fs: use standard kernel byteswapping routines
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050828214656.GA11613@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125263107.17501.23.camel@localhost.localdomain>
	 <20050828214656.GA11613@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Sun, Aug 28, 2005 at 04:05:07PM -0500, Eric Van Hensbergen wrote:
> > [PATCH] v9fs: use standard kernel byteswapping routines
> >
> > Originally suggested by hch, we have removed our byteswap code
> > and replaced it with calls to the standard kernel byteswapping code.
> 
> > -     buf->p[0] = val;
> > -     buf->p[1] = val >> 8;
> > +     *(u16 *) buf->p = cpu_to_le16(val);
> 
> *(__le16 *)
> 
> > -     ret = buf->p[0] | (buf->p[1] << 8);
> > +     ret = le16_to_cpu(*(u16 *)buf->p);
> 
> *(__le16 *) etc.
> 
> Otherwise sparse will warn.
> 

It didn't give me any complaints -- I'm building my kernels with a
recent (updated today) version of sparse and built with C=1 -- am I
not invoking it correctly?

            -eric
