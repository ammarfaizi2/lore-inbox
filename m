Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268183AbUIQEsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268183AbUIQEsi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268322AbUIQEsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:48:38 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:25682 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268183AbUIQEsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:48:36 -0400
Date: Fri, 17 Sep 2004 06:49:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thayne Harbaugh <tharbaugh@lnxi.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [PATCH] gen_init_cpio uses external file list
Message-ID: <20040917044959.GA8338@mars.ravnborg.org>
Mail-Followup-To: Thayne Harbaugh <tharbaugh@lnxi.com>,
	akpm@digeo.com, linux-kernel@vger.kernel.org, klibc@zytor.com
References: <1095372672.19900.72.camel@tubarao>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095372672.19900.72.camel@tubarao>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 04:11:12PM -0600, Thayne Harbaugh wrote:
> 
> This patch makes gen_init_cpio generate the initramfs_data.cpio from a
> file which contains a list of entries: file, dir, nod.  I swapped the
> order of filename/location for the file arguments so that it would be
> more uniform with the dir and nod tyes.

Comments already given on klibc list by others, but repeated for lkml readers.

Helper programs like this shall be compatible with at least solaris & cygwin.
Therefore the linux only stuff needs to be avoided.

 +	char name[PATH_MAX + 1];
> +	unsigned int mode;
> +	uid_t uid;
> +	gid_t gid;
> +	int rc = -1;
> +
> +	if (4 != sscanf(line, "%" str(PATH_MAX) "s %o %d %d", name, &mode, &uid, &gid)) {
> +		fprintf(stderr, "Unrecognized dir format '%s'", line);
> +		goto fail;

Do we know that uid_t and gid_t equals an int here?
Use an int in the sscanf and do explicit type conversion later.


> +	while (-1 != getline(&line, &line_sz, cpio_list)) {
> +		int type_idx;

fgets() please.

	Sam
