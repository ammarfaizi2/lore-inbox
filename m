Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVIXAJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVIXAJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 20:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVIXAJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 20:09:16 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:49876 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932132AbVIXAJP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 20:09:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XY4y9oXp1FpO+rDSVnosfvk9ZxbNhqoArtf0MTD8bpERoFm83tJoTl8OS+m477+f03Ty3qafaX7SZ8l0DhADtKB/yW40734OcKAyTJHROv0W4+Fs0vrIbibOdggQ0ePUGC7udgD1OOLE97/kdVwe/szjHD+kujJEtJHF9heLVaQ=
Message-ID: <9a8748490509231709481e3323@mail.gmail.com>
Date: Sat, 24 Sep 2005 02:09:15 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] reduce sizeof(struct file)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050924013021.1130f3c8@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17AB476A04B7C842887E0EB1F268111E026FC5@xpserver.intra.lexbox.org>
	 <4333CF4C.2000306@anagramm.de> <4333D2AA.6020009@cosmosbay.com>
	 <20050923100541.GA18447@infradead.org>
	 <20050924013021.1130f3c8@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/05, J.A. Magallon <jamagallon@able.es> wrote:
> On Fri, 23 Sep 2005 11:05:41 +0100, Christoph Hellwig <hch@infradead.org> wrote:
>
> > On Fri, Sep 23, 2005 at 12:02:18PM +0200, Eric Dumazet wrote:
> > > Hi all
> > >
> > > Now that RCU applied on 'struct file' seems stable, we can place f_rcuhead
> > > in a memory location that is not anymore used at call_rcu(&f->f_rcuhead,
> > > file_free_rcu) time, to reduce the size of this critical kernel object.
> > >
> > > The trick I used is to move f_rcuhead and f_list in an union and defining
> > > macros to access f_list and f_rcuhead
> > >
> > > Unfortunatly f_list was also used in IPVS so I had to change
> > > include/net/ip_vs.h and net/ipv4/ipvs/ip_vs_ctl.c, changing their f_list to
> > > ipvs_f_list to avoid name clash.
> > >
> > > (This is why I send this mail to IPVS maintainers)
> >
> > Please just change all callers to use the union, there's not very many
> > of them.
> >
>
> How about anonymous unions ? gcc-3.3.3 and above support them.
> Is 2.6 supposed to be built with 2.95 ?
>
Yes, 2.6.x is expected to build with gcc 2.95.3+

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
