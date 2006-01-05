Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWAEQR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWAEQR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWAEQR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:17:56 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:48100 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751328AbWAEQRz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:17:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bMWtnlJlRC+p/2iy/n+ZtSh/UFwxSYn5c0Bqq39y9KyVs0u/VTVpyJkWgHTMYmowve065XzIldOyPW9IfEKArwMb9bY9Tyo6l2wL/OOBnhZ1k54syPqAapEWo9PugYTUhuaBV9VjH5PRz62YXHmeEPTwTKlxgUuC0co7UbMws8E=
Message-ID: <9cfa10eb0601050817u56b007dbj@mail.gmail.com>
Date: Thu, 5 Jan 2006 18:17:51 +0200
From: Marko Kohtala <marko.kohtala@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC]: add sysfs support to parport_pc, v3
Cc: Jason Dravet <dravet@hotmail.com>, greg@kroah.com, device@lanana.org,
       linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
In-Reply-To: <20060104143157.357f9830.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060104010841.GA19541@kroah.com>
	 <BAY103-F400667AF1AF50590C4990CDF2F0@phx.gbl>
	 <20060104143157.357f9830.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/5, Andrew Morton <akpm@osdl.org>:
> "Jason Dravet" <dravet@hotmail.com> wrote:
> > >From: Greg KH <greg@kroah.com>
> > > > + * Added sysfs and udev - Jason Dravet <dravet@hotmail.com>
> > > >  */
>
> 6 is OK - it's LP_MAJOR.
>
> However 99 is JSFD_MAJOR, used by drivers/sbus/char/jsflash.c.  And yet my
> /dev/parport0 is also 99:0 (RH 7.3 and RH FC1).  I've no idea how that came
> about??
>
> bix:/home/akpm> grep parport /etc/makedev.d/*
> /etc/makedev.d/generic:a generic parport
> /etc/makedev.d/linux-2.4.x:c $PRINTER              99   0  1   8 parport%d

JSFD is a block device so tha majors are ok. I'm not just sure if the
PP_MAJOR from linux/ppdev.h should be moved to major.h.

The patch by Jason however is not ok. He had another problem and this
is not the fix. What he tries to do is already in lp and ppdev, where
I think they belong.

There is also something weird: why does RedHat create these nodes in
/dev when udev already does that.
