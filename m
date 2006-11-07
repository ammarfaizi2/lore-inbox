Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753361AbWKGWGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361AbWKGWGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbWKGWGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:06:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:63972 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1753361AbWKGWGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:06:32 -0500
Date: Tue, 7 Nov 2006 16:06:27 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       chris friedhoff <chris@friedhoff.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] security: introduce file posix caps
Message-ID: <20061107220627.GA11647@sergelap.austin.ibm.com>
References: <20061107034550.GA13693@sergelap.austin.ibm.com> <20061107215444.GO30208@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061107215444.GO30208@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Seth Arnold (seth.arnold@suse.de):
> On Mon, Nov 06, 2006 at 09:45:50PM -0600, Serge E. Hallyn wrote:
> >  #define CAP_AUDIT_CONTROL    30
> >  
> > +#define CAP_NUMCAPS	     31
> 
> [...]
> 
> > +struct vfs_cap_data_struct {
> > +	__u32 version;
> > +	__u32 effective;
> > +	__u32 permitted;
> > +	__u32 inheritable;
> > +};
> 
> [...]
> 
> > +static int check_cap_sanity(struct vfs_cap_data_struct *cap)
> > +{
> > +	int i;
> > +
> > +	if (cap->version != _LINUX_CAPABILITY_VERSION)
> > +		return -EPERM;
> > +
> > +	for (i=CAP_NUMCAPS; i<sizeof(cap->effective); i++) {
> > +		if (cap->effective & CAP_TO_MASK(i))
> > +			return -EPERM;
> > +	}
> > +	for (i=CAP_NUMCAPS; i<sizeof(cap->permitted); i++) {
> > +		if (cap->permitted & CAP_TO_MASK(i))
> > +			return -EPERM;
> > +	}
> > +	for (i=CAP_NUMCAPS; i<sizeof(cap->inheritable); i++) {
> > +		if (cap->inheritable & CAP_TO_MASK(i))
> > +			return -EPERM;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> for (i=31; i<4; i++) ...
> 
> I'm not sure this checks what you think it checks? :)

Hah!  Thanks for catching that.

I will send a fix out tonight.

-serge
