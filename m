Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVBRBu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVBRBu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 20:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBRBu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 20:50:27 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:41620 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261254AbVBRBuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 20:50:18 -0500
Date: Fri, 18 Feb 2005 02:50:17 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] add umask parameter to procfs
Message-ID: <20050218015017.GA5044@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <20050217212859.GA24403@lsrfire.ath.cx> <20050217154119.1f237921.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217154119.1f237921.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 03:41:19PM -0800, Andrew Morton wrote:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> >
> > Add proc.umask kernel parameter.  It can be used to restrict permissions
> > on the numerical directories in the root of a proc filesystem, i.e. the
> > directories containing process specific information.
> > 
> > E.g. add proc.umask=077 to your kernel command line and all users except
> > root can only see their own process details (like command line
> > parameters) with ps or top.  It can be useful to add a bit of privacy to
> > multi-user servers.
> > 
> > The patch has been inspired by a similar feature in GrSecurity.
> > 
> > It could have also been implemented as a mount option to procfs, but at
> > a higher cost and no apparent benefit -- changes to this umask are not
> > supposed to happen very often.  Actually, the previous incarnation of
> > this patch was implemented as a half-assed mount option, but I didn't
> > know then how easy it is to add a kernel parameter.
> 
> The feature seems fairly obscure, although very simple.  
> Is anyone actually likely to use this?

what about parents (and especially the init process)
some tools like pstree (or ps in certain cases) depend
on their visibility/accessability ...

was this tested except for the trivial case where
just plain everything is visible?

what if you want to change it afterwards (when tools
did break)?

best,
Herbert

> > +static umode_t umask = 0;
> 
> a) I think the above should be called proc_umask.
> 
> b) You shouldn't initialise it.
> 
> c) When adding a kernel parameter you should update
>    Documentation/kernel-parameters.txt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
