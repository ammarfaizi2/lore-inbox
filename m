Return-Path: <linux-kernel-owner+w=401wt.eu-S932277AbWLLRe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWLLRe0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWLLReZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:34:25 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:65258 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932277AbWLLReZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:34:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=oxw7S+XYFn7Bd59+ae1Yxo6X0/+PeBxNsxTSkfmse8jmiB7wRj/RL7IHv9GU/lPoLHNK9t2axsGlWhlH/e0c7JP999UOY08gd/ojMKCAYlWNZzZodK35C4rrLLt+9MH+JvBWQ9wkfzaOaP/UJ/zBz6TMSrmAa8sqm8Vf9n05+lI=
Message-ID: <84144f020612120934n612f513er606d2653f527eb67@mail.gmail.com>
Date: Tue, 12 Dec 2006 19:34:23 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Yan Burman" <burman.yan@gmail.com>
Subject: Re: [PATCH 2.6.19] e1000: replace kmalloc with kzalloc
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, cramerj@intel.com
In-Reply-To: <1165942389.5611.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165942389.5611.4.camel@localhost>
X-Google-Sender-Auth: 7579d009d142be2f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Yan Burman <burman.yan@gmail.com> wrote:
>         size = txdr->count * sizeof(struct e1000_buffer);
> -       if (!(txdr->buffer_info = kmalloc(size, GFP_KERNEL))) {
> +       if (!(txdr->buffer_info = kzalloc(size, GFP_KERNEL))) {
>                 ret_val = 1;
>                 goto err_nomem;
>         }
> -       memset(txdr->buffer_info, 0, size);

No one seems to be using size elsewhere so why not convert to
kcalloc() and get rid of it? (Seems to apply to other places as well.)
