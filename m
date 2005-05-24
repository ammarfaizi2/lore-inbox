Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVEXJO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVEXJO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVEXJOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:14:39 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:3001 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261460AbVEXJMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:12:03 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091201.3BCE0FB16@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:12:01 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 4E3C4FB60

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 09:58:21 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261383AbVEXHOX (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 03:14:23 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVEXHOT

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 03:14:19 -0400

Received: from wproxy.gmail.com ([64.233.184.193]:33354 "EHLO wproxy.gmail.com")

	by vger.kernel.org with ESMTP id S261383AbVEXHON convert rfc822-to-8bit

	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 03:14:13 -0400

Received: by wproxy.gmail.com with SMTP id 68so2500606wri

        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2005 00:14:13 -0700 (PDT)

DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;

        s=beta; d=gmail.com;

        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;

        b=Y+AtHMac8HQzy5TaUfp4m0PBpzm0oAMdJiagefK39WeGGEUJ5tsNmxB8/E8QQ7ogyF+wwNow0lFWPQSmPezl80gGMfsCCrapBjh+Y3kxnJgLm65p+UG0vlwELW1k6BUnnasteKf0+Tw6+L+5o+csx3BfGv0UYJXZvu2OxvCB+hw=

Received: by 10.54.117.4 with SMTP id p4mr4023181wrc;

        Tue, 24 May 2005 00:14:13 -0700 (PDT)

Received: by 10.54.66.13 with HTTP; Tue, 24 May 2005 00:14:12 -0700 (PDT)

Message-ID: <84144f0205052400143e97796e@mail.gmail.com>

Date:	Tue, 24 May 2005 10:14:12 +0300

From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "ericvh@gmail.com" <ericvh@gmail.com>
Subject: Re: [RFC][patch 2/7] v9fs: VFS file and directory operations (2.0-rc6)

Cc: linux-kernel@vger.kernel.org,
	v9fs-developer@lists.sourceforge.net,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, penberg@cs.helsinki.fi
In-Reply-To: <200505232225.j4NMPXe1029024@ms-smtp-02-eri0.texas.rr.com>

Mime-Version: 1.0

Content-Type:	text/plain; charset=US-ASCII

Content-Transfer-Encoding: 7BIT

Content-Disposition: inline

References: <200505232225.j4NMPXe1029024@ms-smtp-02-eri0.texas.rr.com>

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



Hi,

On 5/24/05, ericvh@gmail.com <ericvh@gmail.com> wrote:
> +static ssize_t
> +v9fs_file_write(struct file *filp, const char __user * data,
> +               size_t count, loff_t * offset)
> +{
> +       int ret = -1;
> +       char *buffer;
> +
> +       buffer = kmalloc(count, GFP_KERNEL);
> +       if (buffer == NULL) {
> +               BUG();

I think simply returning -ENOMEM is sufficient. BUG seems way too
aggressive. (Found this in other places as well.)

> +               return -ENOMEM;
> +       }

                    Pekka
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

