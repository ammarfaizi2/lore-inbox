Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVI2Qlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVI2Qlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVI2Qlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:41:36 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:7602 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932209AbVI2Qlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:41:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=tzPdiLHoU566A097fdgj6iFJKWhJnNWbkkSsXY9KL3o1RvBGG1KSnOaEoVjeHr+M6GbsnDVH6fUUt2Fk1tdz/TST6tyYAYrL+J2mwGldOms+QsDbyCNgCUVsapiB8LfyTn3tXhioIC54zBMG1WhgR8drVJ6CK1BuIaVYM8wK80U=
Date: Thu, 29 Sep 2005 20:52:36 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rio: switch to ANSI prototypes
Message-ID: <20050929165236.GC18132@mipter.zuzino.mipt.ru>
References: <20050929152208.GA18132@mipter.zuzino.mipt.ru> <20050929152556.GU7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929152556.GU7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 04:25:56PM +0100, Al Viro wrote:
> Uh-oh...  Well, if you want to play with it...  FWIW, I'm disabling rio as
> hopeless FPOS; if you feel masochistic, go ahead but keep in mind that its
> handling of tty glue is severely b0rken.

Well, duh... It clutters _my_ logs.

> >  int
> > -RIOBootCodeHOST(p, rbp)
> > -struct rio_info *	p;
> > -register struct DownLoad *rbp;
> > +RIOBootCodeHOST(struct rio_info *p, register struct DownLoad *rbp)
> 
> s/register//

Sure.

> >  int
> > -riocontrol(p, dev, cmd, arg, su)
> > -struct rio_info	* p;
> > -dev_t		dev;
> > -int		cmd;
> > -caddr_t		arg;
> > -int		su;
> > +riocontrol(struct rio_info *p, dev_t dev, int cmd, caddr_t arg, int su)
> 
> Use of dev_t here is almost certainly broken.

It is with the only call being

drivers/char/rio/rio_linux.c:
   642    /* The "dev" argument isn't used. */
   643    rc = riocontrol (p, 0, cmd, (void *)arg, capable(CAP_SYS_ADMIN));

Though riocontrol() happily does MAJOR(dev) three times.

> Use of caddr_t is *always* broken.

"unsigned long arg" or do you keep in mind something more fundamental? 

