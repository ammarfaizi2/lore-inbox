Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWEBLTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWEBLTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 07:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWEBLTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 07:19:35 -0400
Received: from wproxy.gmail.com ([64.233.184.239]:63304 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932226AbWEBLTd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 07:19:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Mnsv1qEGpk+1vP7u4ucLMgEIeDfqdMwTXlY2E3Ymnb6QYERNZSKcFSQVuGu2w1VkfagzB3JEybreaZgoed7Pm487IOLJreASoAyIiFF0etFWBNTelbTBrrYe4+XjKMaKI7im0CGuqKMS7MqW5buMtImt799VdHuL3BBzWbSyJOQ=
Message-ID: <84144f020605020419o539c377do7a01314980a44d67@mail.gmail.com>
Date: Tue, 2 May 2006 14:19:32 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Petri T. Koistinen" <petri.koistinen@iki.fi>
Subject: Re: [PATCH] fs/isofs/namei.c: fix warnings of uninitialized variables
Cc: "Andrew Morton" <akpm@osdl.org>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0605012255290.15813@joo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0605012255290.15813@joo>
X-Google-Sender-Auth: 9856cc17872318fe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/06, Petri T. Koistinen <petri.koistinen@iki.fi> wrote:
> From: Petri T. Koistinen <petri.koistinen@iki.fi>
>
> Remove warnings by initializing uninitialized variables.
>
> Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>
> ---
>  fs/isofs/namei.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> ---
> diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
> index e7ba0c3..e0d6531 100644
> --- a/fs/isofs/namei.c
> +++ b/fs/isofs/namei.c
> @@ -159,7 +159,7 @@ isofs_find_entry(struct inode *dir, stru
>  struct dentry *isofs_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
>  {
>         int found;
> -       unsigned long block, offset;
> +       unsigned long block = 0, offset = 0;

NAK. Both are initialized by isofs_find_entry() before being used.

                                                Pekka
