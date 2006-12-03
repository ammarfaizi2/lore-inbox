Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756986AbWLCQiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986AbWLCQiB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757015AbWLCQiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:38:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:62203 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1756986AbWLCQiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:38:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=qDAGRmKlfV3wWsYZ7RTB/uCkGiCRYGC6OP6Nx+mrOG/CM1xqmlQQ2oHVs0Gs9sx3AncjTcnC/AHMlhqX5tK0HWfWNhv2CwgSuPON2T4guDMUpuvQoPYRHgNOpcF0R/Tq1nU5haAczgymUEZmOWq+QM/0y5BG5oxSktOSAXtF/UM=
Message-ID: <4572FD63.4010101@gmail.com>
Date: Sun, 03 Dec 2006 17:37:32 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: Convert kmalloc()+memset() combo to kzalloc().
References: <Pine.LNX.4.64.0612031120110.4371@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612031120110.4371@localhost.localdomain>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   Convert all obvious combinations of kmalloc()+memset() to single
> kzalloc() in the fs/ directory.
[snip]
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 555b9ac..f85feba 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -31,12 +31,11 @@ int seq_open(struct file *file, struct s
>  	struct seq_file *p = file->private_data;
> 
>  	if (!p) {
> -		p = kmalloc(sizeof(*p), GFP_KERNEL);
> +		p = kzalloc(sizeof(*p), GFP_KERNEL);
>  		if (!p)
>  			return -ENOMEM;
>  		file->private_data = p;
>  	}
> -	memset(p, 0, sizeof(*p));
>  	mutex_init(&p->lock);
>  	p->op = op;

It's not the same! Previous erases it every time seq_open is called and after
your change only once -- when p == NULL.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
