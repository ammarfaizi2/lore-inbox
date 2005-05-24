Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVEXJjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVEXJjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVEXJhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:37:03 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:58304 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261799AbVEXJQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:16:59 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091657.EFC9AFA3B@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:16:57 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 9E548FB76

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:47 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261380AbVEXHLm (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 03:11:42 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVEXHLm

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 03:11:42 -0400

Received: from wproxy.gmail.com ([64.233.184.198]:55599 "EHLO wproxy.gmail.com")

	by vger.kernel.org with ESMTP id S261380AbVEXHLf convert rfc822-to-8bit

	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 03:11:35 -0400

Received: by wproxy.gmail.com with SMTP id 68so2499905wri

        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2005 00:11:34 -0700 (PDT)

DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;

        s=beta; d=gmail.com;

        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;

        b=tvIhVOeAzDNbsvJvSQ5uiPWVf1N9fUHV/ILTH1RV6NCU8oFfa/Deuwxu8gnPnKO2oOPcW9uTpMLIC9RWUkUYORUvUUF5ovlT66teN2p4kc1mPLda7J/oL/8dMHdOkC54WTfaWuiTjdCwq+AD65PTFOYTBk4bAGyeGa/JpWda7Uo=

Received: by 10.54.37.78 with SMTP id k78mr3954580wrk;

        Tue, 24 May 2005 00:11:34 -0700 (PDT)

Received: by 10.54.66.13 with HTTP; Tue, 24 May 2005 00:11:34 -0700 (PDT)

Message-ID: <84144f0205052400113c6f40fc@mail.gmail.com>

Date:	Tue, 24 May 2005 10:11:34 +0300

From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "ericvh@gmail.com" <ericvh@gmail.com>
Subject: Re: [RFC][patch 4/7] v9fs: VFS superblock operations (2.0-rc6)

Cc: linux-kernel@vger.kernel.org,
	v9fs-developer@lists.sourceforge.net,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, penberg@cs.helsinki.fi
In-Reply-To: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>

Mime-Version: 1.0

Content-Type:	text/plain; charset=US-ASCII

Content-Transfer-Encoding: 7BIT

Content-Disposition: inline

References: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



Hi,

On 5/24/05, ericvh@gmail.com <ericvh@gmail.com> wrote:
> Index: fs/9p/v9fs.c
> ===================================================================
> --- /dev/null  (tree:0bf32353105286a5624aeea862d35a4bbae09851)
> +++ 178666ee376655ef8ec19a2ffc0490241b428110/fs/9p/v9fs.c  (mode:100644)
> @@ -0,0 +1,573 @@
> +/*
> +  * Fcall Slab Accounting
> +  */
> +
> +struct v9fs_slab {
> +       struct list_head list;
> +
> +       int size;
> +       kmem_cache_t *slab;
> +};
> +
> +static LIST_HEAD(v9fs_slab_list);

[snip]

> +
> +/**
> + * find_slab - look up a slab by size
> + * @size: size of slab data
> + *
> + */
> +
> +static inline kmem_cache_t *find_slab(int size)

Hmm? Why do you need this? If you're missing functionality from the
slab allocator, please put that in mm/slab.c, not your filesystem!

> +void v9fs_session_close(struct v9fs_session_info *v9ses)
> +{

[snip]

> +       if (v9ses->name) {
> +               kfree(v9ses->name);
> +       }

kfree() handles NULL pointers just fine, so please drop the redundant
check (here and in various other places too).

                       Pekka
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

