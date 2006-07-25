Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWGYPIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWGYPIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWGYPIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:08:21 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:46255 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932398AbWGYPIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:08:20 -0400
Date: Tue, 25 Jul 2006 11:08:17 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Kylene Jo Hall <kjhall@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 2/6] Integrity Service API and dummy provider
In-Reply-To: <1153763479.5171.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607251104380.21352@d.namei>
References: <1153763479.5171.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Kylene Jo Hall wrote:

> + * @verify_data:
> + *	Verify the integrity of a dentry.
> + *	@dentry contains the dentry structure to be verified.
> + *	Possible return codes are: INTEGRITY_PASS, INTEGRITY_FAIL,
> + * 		INTEGRITY_NOLABEL
> + *
> + * @verify_metadata:
> + *	Verify the integrity of a dentry's metadata; return the value
> + * 	of the requested xattr_name and the verification result of the
> + *	dentry's metadata.
> + *	@dentry contains the dentry structure of the metadata to be verified.
> + *	@xattr_name, if not null, contains the name of the xattr
> + *		 being requested.
> + *	@xattr_value, if not null, is a pointer for the xattr value.
> + *	@xattr_val_len will be set to the length of the xattr value.
> + *	@xattr_status is the result of the getxattr request for the xattr.
> + *	Possible return codes are: INTEGRITY_PASS, INTEGRITY_FAIL,
> + *		INTEGRITY_NOLABEL, -EOPNOTSUPP, -ENOMEM,

What I would suggest with these API calls is that they always only return 
errno values, and that you pass back the INTEGRITY_ values via a pointer.

This ensures that errno values are cleanly propagated throughout the 
kernel and that 'system' errors are separated from higher level integrity 
service status values.


-- 
James Morris
<jmorris@namei.org>
