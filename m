Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVAYWt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVAYWt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVAYWsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:48:31 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:5000 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262204AbVAYWqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:46:42 -0500
Subject: Re: [PATCH 1/2] Disallow appends to sysfs files
From: Josh Boyer <jdub@us.ibm.com>
To: Mitch Williams <mitch.a.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <Pine.CYG.4.58.0501251429490.696@mawilli1-desk2.amr.corp.intel.com>
References: <Pine.CYG.4.58.0501251429490.696@mawilli1-desk2.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1106693200.6955.9.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 25 Jan 2005 16:46:40 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 16:38, Mitch Williams wrote:
> This patch causes an error to be returned if the caller attempts to open a
> sysfs file in append mode.
> 
> This patch applies cleanly to 2.6.11-rc1.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> 
> diff -urpN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
> --- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
> +++ linux-2.6.11/fs/sysfs/file.c	2005-01-24 16:26:21.000000000 -0800
> @@ -275,6 +275,11 @@ static int check_perm(struct inode * ino
>  	if (!ops)
>  		goto Eaccess;
> 
> +	/* Is the file is open for append?  Sorry, we don't do that. */
> +	if (file->f_flags & O_APPEND) {
> +		goto Einval;
> +	}
> +

Could you drop the braces?  Coding style thing.

thx,
josh

