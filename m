Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWBXVFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWBXVFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWBXVFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:05:17 -0500
Received: from mail8.sea5.speakeasy.net ([69.17.117.10]:687 "EHLO
	mail8.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932494AbWBXVFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:05:15 -0500
Date: Fri, 24 Feb 2006 16:05:13 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Steven Whitehouse <swhiteho@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [9/16]
In-Reply-To: <1140793283.6400.726.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.64.0602241559460.8198@excalibur.intercode>
References: <1140793283.6400.726.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Steven Whitehouse wrote:


> +/**
> + * gfs2_ea_name2type - get the type of the ea, and truncate type from the name
> + * @namep: ea name, possibly with type appended
> + *
> + * Returns: GFS2_EATYPE_XXX
> + */
> +
> +unsigned int gfs2_ea_name2type(const char *name, char **truncated_name)
> +{
> +	unsigned int type;
> +
> +	if (strncmp(name, "system.", 7) == 0) {
> +		type = GFS2_EATYPE_SYS;
> +		if (truncated_name)
> +			*truncated_name = strchr(name, '.') + 1;
> +	} else if (strncmp(name, "user.", 5) == 0) {
> +		type = GFS2_EATYPE_USR;
> +		if (truncated_name)
> +			*truncated_name = strchr(name, '.') + 1;
> +	} else {
> +		type = GFS2_EATYPE_UNUSED;
> +		if (truncated_name)
> +			*truncated_name = NULL;
> +	}
> +
> +	return type;
> +}


Consider using the generic xattr infrastructure in the kernel (xattr.c), 
e.g. generic_getxattr() and friends.



- James
-- 
James Morris
<jmorris@namei.org>
