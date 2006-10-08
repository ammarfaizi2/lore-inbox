Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWJHP3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWJHP3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWJHP3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:29:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:62832 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751223AbWJHP3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:29:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mIax7pioW63vEYOI2sk5NyEDzzjWvwHLpP4hsGYX02IbPs3hnlneDBk5fpQiEGdpkJTPAGvOYLcA58Yo5YOvVGcUaUQFyWd2KUkiCPuVldIE1zGQU/2JU1mBXHpZgJln10PqzF64d1utSNIR4hPCEyjbU0bIXvJeqpm2Vq+Qu4M=
Message-ID: <9a8748490610080829r54053e14ud8c7b02c8f39476c@mail.gmail.com>
Date: Sun, 8 Oct 2006 17:29:01 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] Minor coding style fix
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <452913DB.4010409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <452913DB.4010409@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/06, Aneesh Kumar K.V <aneesh.kumar@gmail.com> wrote:
> Kernel generally follow the style
>
> if (func()) {
> /* failed case */
> } else {
> /* success */
> }
>
>

Please submit patches inline, having to copy them from attachments to
be able to reply is a pain.

>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 98489d8..55cb77c 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -517,7 +517,7 @@ EXPORT_SYMBOL_GPL(srcu_notifier_call_cha
>  void srcu_init_notifier_head(struct srcu_notifier_head *nh)
>  {
>  	mutex_init(&nh->mutex);
> -	if (init_srcu_struct(&nh->srcu) < 0)
> +	if (init_srcu_struct(&nh->srcu))
>  		BUG();
>  	nh->head = NULL;
>  }

I really liked the old code better. If in the future
init_srcu_struct() is changed to also return >0 for some conditions,
then that would not previously have triggered BUG(), but after your
changes it will. The code, as it were, perfectly expressed what it
wanted to happen - if it returns less than zero it's a BUG().
I say leave it alone.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
