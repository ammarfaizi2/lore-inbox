Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWAOACj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWAOACj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 19:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWAOACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 19:02:39 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:49297 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750704AbWAOACi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 19:02:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=diolo2/4Yn1yQc3INGINKdZ6ureW3xr+jweBtL0aRRCfoMLTpl82ASJ9mARZ5gXBUj4rDipz1ojl2qIshC40t72gczYtiPv22BXcR3m26rE4RoEOcqBxQTblAZAHOvZ+b3yS8ybr2/prW6liHb+X+whzP4iiWUrfOhgXOtE4MUI=
Message-ID: <a36005b50601141602y641567ebh5ff9b6a1fad4d7d2@mail.gmail.com>
Date: Sat, 14 Jan 2006 16:02:37 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: David Singleton <dsingleton@mvista.com>
Subject: Re: [robust-futex-1] futex: robust futex support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <43C84D4B.70407@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43C84D4B.70407@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, David Singleton <dsingleton@mvista.com> wrote:
=============================================
> --- linux-2.6.15.orig/include/asm-generic/errno.h
> +++ linux-2.6.15/include/asm-generic/errno.h
> @@ -105,5 +105,6 @@
>  /* for robust mutexes */
>  #define        EOWNERDEAD      130     /* Owner died */
>  #define        ENOTRECOVERABLE 131     /* State not recoverable */
> +#define ENOTSHARED     132     /* no pshared attribute */

Do not introduce a new error code if at all possible.  Adding
userlang-visible error codes means the ABI changes due to the stupid
_sys_errlist variable.  Just reuse an error code which cannot be
returned in the futex code so far and which has some kind of
resemblence with what the error means.
