Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754739AbWKIF1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbWKIF1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 00:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbWKIF1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 00:27:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:30761 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754739AbWKIF1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 00:27:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=cHA09uviYzvHvgmMc5L1gSePGtw6Gjut6lT35yumIPjXQGpx/vB7jB88fTOejT7/95xMMV4CFn7IE7I7Pv5eDPD0pF/z6uwtaWzEmFTbCsrW5WhF/4u0ImE9F72fy3nwAxocER6GriT+WG2BBtKS/gQpW55ZgXHksqfKFUBwsDQ=
Date: Thu, 9 Nov 2006 08:27:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Chris Friedhoff <chris@friedhoff.org>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061109052733.GA4976@martell.zuzino.mipt.ru>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061108224837.GG4972@martell.zuzino.mipt.ru> <20061108235203.GA7987@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108235203.GA7987@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 05:52:03PM -0600, Serge E. Hallyn wrote:
> > > +	__u32 version;
> > > +	__u32 effective;
> > > +	__u32 permitted;
> > > +	__u32 inheritable;
> > > +};
> > > +
> > > +static inline void convert_to_le(struct vfs_cap_data_struct *cap)
> > > +{
> > > +	cap->version = le32_to_cpu(cap->version);
> > > +	cap->effective = le32_to_cpu(cap->effective);
> > > +	cap->permitted = le32_to_cpu(cap->permitted);
> > > +	cap->inheritable = le32_to_cpu(cap->inheritable);
> > > +}
> >
> > This pretty much defeats sparse endian checking. You will get warnings
> > regardless of whether u32 or le32 are used.
>
> But I don't get any sparse warnings with make C=1.  Am I doing something
> wrong?

You need (temporarily) to use CF:

	make C=1 CF=-D__CHECK_ENDIAN__ ...

