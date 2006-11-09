Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161815AbWKIGRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161815AbWKIGRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 01:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbWKIGRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 01:17:12 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:10923 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1754740AbWKIGRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 01:17:10 -0500
Date: Thu, 9 Nov 2006 00:17:07 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Chris Friedhoff <chris@friedhoff.org>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-ID: <20061109061707.GB32696@sergelap.austin.ibm.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com> <20061108224837.GG4972@martell.zuzino.mipt.ru> <20061108235203.GA7987@sergelap.austin.ibm.com> <20061109052733.GA4976@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109052733.GA4976@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexey Dobriyan (adobriyan@gmail.com):
> On Wed, Nov 08, 2006 at 05:52:03PM -0600, Serge E. Hallyn wrote:
> > > > +	__u32 version;
> > > > +	__u32 effective;
> > > > +	__u32 permitted;
> > > > +	__u32 inheritable;
> > > > +};
> > > > +
> > > > +static inline void convert_to_le(struct vfs_cap_data_struct *cap)
> > > > +{
> > > > +	cap->version = le32_to_cpu(cap->version);
> > > > +	cap->effective = le32_to_cpu(cap->effective);
> > > > +	cap->permitted = le32_to_cpu(cap->permitted);
> > > > +	cap->inheritable = le32_to_cpu(cap->inheritable);
> > > > +}
> > >
> > > This pretty much defeats sparse endian checking. You will get warnings
> > > regardless of whether u32 or le32 are used.
> >
> > But I don't get any sparse warnings with make C=1.  Am I doing something
> > wrong?
> 
> You need (temporarily) to use CF:
> 
> 	make C=1 CF=-D__CHECK_ENDIAN__ ...

Ah, cool, now I see it, will try to fix.

thanks,
-serge
