Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWB0IQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWB0IQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWB0IQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:16:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55494 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751685AbWB0IQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:16:44 -0500
Subject: Re: GFS2 Filesystem [9/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602241559460.8198@excalibur.intercode>
References: <1140793283.6400.726.camel@quoit.chygwyn.com>
	 <Pine.LNX.4.64.0602241559460.8198@excalibur.intercode>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 27 Feb 2006 08:21:55 +0000
Message-Id: <1141028515.6400.763.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-02-24 at 16:05 -0500, James Morris wrote:
> On Fri, 24 Feb 2006, Steven Whitehouse wrote:
> 
> 
> > +/**
> > + * gfs2_ea_name2type - get the type of the ea, and truncate type from the name
> > + * @namep: ea name, possibly with type appended
> > + *
> > + * Returns: GFS2_EATYPE_XXX
> > + */
> > +
> > +unsigned int gfs2_ea_name2type(const char *name, char **truncated_name)
> > +{
> > +	unsigned int type;
> > +
> > +	if (strncmp(name, "system.", 7) == 0) {
> > +		type = GFS2_EATYPE_SYS;
> > +		if (truncated_name)
> > +			*truncated_name = strchr(name, '.') + 1;
> > +	} else if (strncmp(name, "user.", 5) == 0) {
> > +		type = GFS2_EATYPE_USR;
> > +		if (truncated_name)
> > +			*truncated_name = strchr(name, '.') + 1;
> > +	} else {
> > +		type = GFS2_EATYPE_UNUSED;
> > +		if (truncated_name)
> > +			*truncated_name = NULL;
> > +	}
> > +
> > +	return type;
> > +}
> 
> 
> Consider using the generic xattr infrastructure in the kernel (xattr.c), 
> e.g. generic_getxattr() and friends.
> 
> 
> 
> - James

Yes, I've also had some similar feedback in private email. We will
certainly look into doing this at the same time as we look at the
selinux/xattr support so its high on our agenda now. Thanks for the
feedback,

Steve.


