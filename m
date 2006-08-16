Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWHPUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWHPUWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWHPUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:22:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:47201 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751098AbWHPUWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:22:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gKYtyFKhl4vlgY95wTP/+OKZ0NUUw3sgJZr9n2XieLOEN40HnomnjrUVBUbY9+Lpf+O9Uq+GlfQvZQABPvEynGPnv8uEWik8MOCXaD+sZ813wk17wwaw0yR45p4E69Gz3FRgTPefuaI5HVP3EzfRDVT/YapyQvDOrJu/hLbfn5c=
Message-ID: <9a8748490608161322q64e7d48fmbdf68288db22b64e@mail.gmail.com>
Date: Wed, 16 Aug 2006 22:22:46 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       "Jesper Juhl" <jesper.juhl@gmail.com>,
       "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ISDN: fix double free bug in isdn_net
In-Reply-To: <20060815160657.GA14266@pingi.kke.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608122248.22639.jesper.juhl@gmail.com>
	 <20060815.020004.76775981.davem@davemloft.net>
	 <9a8748490608150208v4e8b7dccl6dd501a6f2cda4fc@mail.gmail.com>
	 <20060815.021503.71555009.davem@davemloft.net>
	 <20060815160657.GA14266@pingi.kke.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/06, Karsten Keil <kkeil@suse.de> wrote:
> On Tue, Aug 15, 2006 at 02:15:03AM -0700, David Miller wrote:
> > From: "Jesper Juhl" <jesper.juhl@gmail.com>
> > Date: Tue, 15 Aug 2006 11:08:35 +0200
> >
> > > Hmm, perhaps I made a mistake and missed a path. Maybe it would be
> > > better to fix if by making isdn_writebuf_skb_stub() always set the skb
> > > to NULL when it does free it. That would add a few more assignments
> > > but should ensure the right result always.
> > > What do you say?
> >
> > Do we know if the ->writebuf_skb() method ever frees the skb?  If it
> > never does, then yes your suggestion would be one way to handle this.
>
>
> It does if it consumes the skb (then it returns skb->len).
> But the skb have not to be freed imediately in this case, it maybe
> queued or used until all bytes are written to the physical device.
>
> If it returns any other value the skb is not freed.
>
> This logic came from using skb for transparent data too.
> Here it was possible, that the hw driver only take some bytes from the
> skb (so it returns < skb->len), then the isdn layer should requeue
> the skb so no transparent data get lost.
>
> But this mechanism was never used in drivers, only 3 states:
>
> The driver accept the packet then it is responsible for the skb
> and return skb->len or the driver do not accept it (e.g. buffer full,
> conntection is going down), then it return 0 and does not free the
> skb.
>
> If some internal error in the HW driver occur, it should return a
> negative value and it also do not free the skb.
>

Ok, if I understand you correctly, then there's no actual problem here.
right?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
