Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269325AbTGJPBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269327AbTGJPBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:01:20 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:51729 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269325AbTGJPBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:01:17 -0400
Date: Thu, 10 Jul 2003 16:15:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710161553.C22512@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
References: <3F0CBC08.1060201@pobox.com> <Pine.LNX.4.55L.0307100040271.6629@freak.distro.conectiva> <20030710085338.C28672@infradead.org> <1057835998.8028.6.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.55L.0307100910550.7857@freak.distro.conectiva> <1057840919.8027.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1057840919.8027.19.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 10, 2003 at 01:42:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 01:42:00PM +0100, Alan Cox wrote:
> On Iau, 2003-07-10 at 13:13, Marcelo Tosatti wrote:
> > So Christoph's quota patch does not support vendors "v1" files?
> > 
> > I must be misunderstanding someone.
> 
> There are three species of quota in Linux
> 
> v0	(official old Linux)
> v1	(most 2.4 vendor trees)
> v2	(the 2.5 format)

Umm, no.  You misunderstood.

There's two quota _ondisk_ formats:

v1 old 16bit quota.
v2 new 32bit quota.

2.4 previously only supported v1, 2.5 and 2.4.22-pre4 also support v2.

There's three sys_quotactl ABIs

1) original 16 bit one, supported by all kernels <= 2.4
2) first 32bit one, supported by 2.4-ac any many vendor trees, but never
   in mainline
3) new 32bit one, supported by 2.4.x (x >= 22-pre4) and 2.5

Unfortunately the second one uses the same constants as the old 16bit one
but different structures so there is no way to support both in a single
kernel.

