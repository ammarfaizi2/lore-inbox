Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWHCKOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWHCKOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 06:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWHCKOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 06:14:45 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:40102 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932460AbWHCKOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 06:14:43 -0400
Date: Thu, 3 Aug 2006 14:13:43 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take3 3/4] kevent: Network AIO, socket notifications.
Message-ID: <20060803101342.GA18885@2ka.mipt.ru>
References: <11545983601447@2ka.mipt.ru> <200608031154.27152.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200608031154.27152.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 14:13:44 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 11:54:26AM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> On Thursday 03 August 2006 11:46, Evgeniy Polyakov wrote:
> > Network AIO, socket notifications.
> >
> > This patchset includes socket notifications and network asynchronous IO.
> > Network AIO is based on kevent and works as usual kevent storage on top
> > of inode.

> > +	file = fget_light(k->event.id.raw[0], &fput_needed);
> > +	if (!file)
> > +		return -ENODEV;
> > +
> > +	err = -EINVAL;
> > +	if (!file->f_dentry || !file->f_dentry->d_inode)
> > +		goto err_out_fput;
> 
> How can you be 100% sure this file is actually a socket here ?
> (Another thread could close the fd and this fd can now point to another file)
> 
> You should do
> if (file->f_op != &socket_file_ops)
> 	goto err_out_fput;
> sk = file->private_data;  /* set in sock_map_fd */ 

That will be socket, not sock, but that check is definitely needed in
both socket and network aio code.
Thanks Eric.

> Eric

-- 
	Evgeniy Polyakov
