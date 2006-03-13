Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWCMPQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWCMPQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 10:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWCMPQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 10:16:21 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:33465 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751091AbWCMPQU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 10:16:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ntzbmJKtY1z53imEd9IXYFsdMA+fbWGBT0NAKBtyc4Meos1GLp5vRuxSpjcWmEgw8gehaZ0rXrYZ+62h5N8w8x5QrW7PpRqQDN4GrLNVgvP8aK6C282hHke5tgA82qqpWpUOOB6gUgw1pxDCnxaiKTej4DjfzlEbXmWc7KrRtDg=
Message-ID: <a36005b50603130716x4cc5306ex2f8ecf012ea052d1@mail.gmail.com>
Date: Mon, 13 Mar 2006 07:16:17 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "GOTO Masanori" <gotom@sanori.org>
Subject: Re: [PATCH] Fix sigaltstack corruption among cloned threads
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <81ek16loay.wl%gotom@sanori.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81ek16loay.wl%gotom@sanori.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, GOTO Masanori <gotom@sanori.org> wrote:
> +        * sigaltstack should be cleared when CLONE_SIGHAND (and CLONE_VM) is
> +        * specified.
> +        */
> +       if (clone_flags & CLONE_SIGHAND)
> +               p->sas_ss_sp = p->sas_ss_size = 0;

I agree in general, but why base it on CLONE_SIGHAND? The problem
results from using the same address space.  So it should be

  if (clone_flags & CLONE_VM)

The fact that both these flags are used at the same time in all cases
today shouldn't hide the real reason for this requirement which is
sharing the address space.
