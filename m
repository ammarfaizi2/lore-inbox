Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266194AbUHFXGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266194AbUHFXGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 19:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267910AbUHFXGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 19:06:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11970 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266194AbUHFXGW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 19:06:22 -0400
Date: Sat, 7 Aug 2004 00:03:05 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix some 32bit isms
Message-ID: <20040806230305.GW12308@parcelfarce.linux.theplanet.co.uk>
References: <20040728135941.GA17409@devserv.devel.redhat.com> <20040728092334.74e0cfcd.akpm@osdl.org> <cf125u$hnt$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf125u$hnt$1@terminus.zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 10:53:50PM +0000, H. Peter Anvin wrote:
> Followup to:  <20040728092334.74e0cfcd.akpm@osdl.org>
> By author:    Andrew Morton <akpm@osdl.org>
> In newsgroup: linux.dev.kernel
> >
> > Alan Cox <alan@redhat.com> wrote:
> > >
> > >  		printk(MYIOC_s_ERR_FMT 
> > >   		     "Invalid IOC facts reply, msgLength=%d offsetof=%d!\n",
> > >  -		     ioc->name, facts->MsgLength, (offsetof(IOCFactsReply_t,
> > >  +		     ioc->name, facts->MsgLength, (int)(offsetof(IOCFactsReply_t,
> > 
> > printk expects %zd for a size_t
> > 
> 
> It should be %zu, since size_t is unsigned.
> 
> %zd is appropriate for ssize_t.

It's signed (and not a ssize_t, while we are at it).  If you want to be
pedantic, use %td since we are dealing with ptrdiff_t here.

BTW, we ought to add 't' modifier in vsnpritf()...
