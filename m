Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWEOWKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWEOWKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWEOWKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:10:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:53410 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964961AbWEOWKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:10:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Z91I9lsVc96n+2fgIMvtVq+TT2z29iW6/1glKBMpyHl82RwgLoDo+3lWKHy/osHEc9w/p6WOr6E0/hPeb3EUUCCRCopswhlTHzC3OQyXOm5Gww1IYK5D1OA9mqarVsbOTysgF0YGCvRiToZsjKm/oPgB4uiLVno33Qki0vvzZ6o=
Date: Tue, 16 May 2006 02:09:03 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alan Cox <alan@redhat.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       Moxa Technologies <support@moxa.com.tw>, Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH 2/3] moxa: remove pointless check of 'tty' argument vs NULL
Message-ID: <20060515220902.GE10143@mipter.zuzino.mipt.ru>
References: <200605152357.36018.jesper.juhl@gmail.com> <20060515215901.GB16994@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515215901.GB16994@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 05:59:01PM -0400, Alan Cox wrote:
> On Mon, May 15, 2006 at 11:57:35PM +0200, Jesper Juhl wrote:
> > Remove pointless check of 'tty' argument vs NULL from moxa driver.
> 
> Can you leave those in for the moment but change them to BUG_ON() because
> I've seen the pop up once or twice. They may be fixed but Im not 100% sure
> yet.

Dereference to get ->driver_data will show the very same backtrace?

	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;

    -	if (!tty || !info->xmit_buf)
> > +	if (!info->xmit_buf)
> >  		return (0);

