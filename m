Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261635AbSJQCR2>; Wed, 16 Oct 2002 22:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbSJQCR2>; Wed, 16 Oct 2002 22:17:28 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:61710 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261635AbSJQCR1>; Wed, 16 Oct 2002 22:17:27 -0400
Date: Wed, 16 Oct 2002 23:23:21 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: make arp seq_file show method only produce one record per call
Message-ID: <20021017022321.GZ7541@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, neilb@cse.unsw.edu.au,
	linux-kernel@vger.kernel.org
References: <20021017011108.GT7541@conectiva.com.br> <20021016.181550.88499112.davem@redhat.com> <15790.4803.492885.687276@notabene.cse.unsw.edu.au> <20021016.182814.23034875.davem@redhat.com> <20021017020001.GV7541@conectiva.com.br> <20021017021028.GW7541@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017021028.GW7541@conectiva.com.br>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 16, 2002 at 11:10:28PM -0300, Arnaldo C. Melo escreveu:
> Em Wed, Oct 16, 2002 at 11:00:01PM -0300, Arnaldo C. Melo escreveu:
> > Em Wed, Oct 16, 2002 at 06:28:14PM -0700, David S. Miller escreveu:
> > >    From: Neil Brown <neilb@cse.unsw.edu.au>
> > >    Date: Thu, 17 Oct 2002 11:30:43 +1000
> > >    
> > >    I use seq->private for private state for /proc/fs/nfs/exports.
> > >    It works nicely.
> > >    You need to define an 'open' the sets it up, and a 'release' to
> > >    tear it down, rather than doing it in start/stop.
> > >    See fs/nfsd/fnsctl.c:exports_open
> > > 
> > > Hmmm, Arnaldo? :-)
> > 
> > 	I know that it works :-) I just refrained from using it because it is
> > not the designed purpose for this field, as per what the author stated to me,
> > so I didn't wanted to use in a way that could change under my feet in the
> > future when Al decided to do some change in seq_file.
> > 
> > 	But if Al changes his mind and state that this is valid use, great,
> > I'll happily use it.
> > 
> > 	See my other post with Al's comments.
> 
> Ok, /me knocks his head on the wall, rereading I think that it is OK, just the
> _pointer_ can't change, oh well, duh, back to work.

Oh, and now that I think about it there is a way to do it without even using
seq_file->private when you need state passed, just allocates a state structure
in seq_start and return it, keeping the pointer to the real object inside this
state structure, together with any other state you need, when the the list is
exhausted, just free the state structure and return NULL, or return NULL and
free the state struct in ->stop, like kernel/module.c:{s_start, s_stop} do, but
I think that what Neil do in NFS is OK, and better, so I'll use seq->private.

- Arnaldo
