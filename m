Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945965AbWJSBxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945965AbWJSBxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945968AbWJSBxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:53:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:41545 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1945965AbWJSBxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:53:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lX2A6PEIEXD+wp3yADyky2wUQ0bPHSDXvm2b2B+oBK0H57/dzHoub6sWfI8miLQuyhVEj0ourrpH2zoRDZ2rYeiOiM81ObnG24/G674sl9OLZmucOilunA+X/cJIktfbCCRO58lX9eRsQkfxU81f9KMgVH2+9qwCIJNHhLzW2TM=
Message-ID: <46465bb30610181853t38428501ha363e6d04b76f993@mail.gmail.com>
Date: Thu, 19 Oct 2006 10:53:42 +0900
From: "Mohit Katiyar" <katiyar.mohit@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: NFS inconsistent behaviour
Cc: "Frank van Maarseveen" <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       "Linux NFS mailing list" <nfs@lists.sourceforge.net>
In-Reply-To: <1161194229.6095.81.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
	 <46465bb30610160013v47524589g39c61465b5955f65@mail.gmail.com>
	 <20061016084656.GA13292@janus>
	 <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
	 <20061016093904.GA13866@janus>
	 <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
	 <20061018063945.GA5917@janus>
	 <1161194229.6095.81.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I do not want to mount unmount infinitely but was just checking
out of curiosity but mounting/unmounting infinitely works comepletely
fine on SLES 9 which uses 2.6.5 kernel. I was just wondering what has
been changed that it does not work now?

On 10/19/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Wed, 2006-10-18 at 08:39 +0200, Frank van Maarseveen wrote:
> > On Wed, Oct 18, 2006 at 10:22:44AM +0900, Mohit Katiyar wrote:
> > > I checked it today and when i issued the netstat -t ,I could see a lot
> > > of tcp connections in TIME_WAIT state.
> > > Is this a normal behaviour?
> >
> > yes... but see below
> >
> > > So we cannot mount and umount infinitely
> > > with tcp option? Why there are so many connections in waiting state?
> >
> > I think it's called the 2MSL wait: there may be TCP segments on the
> > wire which (in theory) could disrupt new connections which reuse local
> > and remote port so the ports stay in use for a few minutes. This is
> > standard TCP behavior but only occurs when connections are improperly
> > shutdown. Apparently this happens when umounting a tcp NFS mount but
> > also for a lot of other tcp based RPC (showmount, rpcinfo).  I'm not
> > sure who's to blame but it might be the rpc functions inside glibc.
> >
> > I'd switch to NFS over udp if this is problem.
>
> Just out of interest. Why does anyone actually _want_ to keep
> mount/umounting to the point where they run out of ports? That is going
> to kill performance in all sorts of unhealthy ways, not least by
> completely screwing over any caching.
>
> Note also that you _can_ change the range of ports used by the NFS
> client itself at least. Just edit /proc/sys/sunrpc/{min,max}_resvport.
> On the server side, you can use the 'insecure' option in order to allow
> mounts that originate from non-privileged ports (i.e. port > 1024).
> If you are using strong authentication (for instance RPCSEC_GSS/krb5)
> then that actually makes a lot of sense, since the only reason for the
> privileged port requirement was to disallow unprivileged NFS clients.
>
> Cheers,
>  Trond
>
>
