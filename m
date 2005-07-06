Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVGFOAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVGFOAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVGFOAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:00:34 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:55421 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262183AbVGFKIg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:08:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bZdm2oapPYp4XEIzh4UjN5Kf3E9DUyruLIuJSMyrynnxSOXDRzy72H5oXGmFsQOfR4ydRaed28hEBjIeClbZsCDN5cwQSWiDEtdodmssAFqp+vQBOr4Z6mFzcByi2eysFnmUk4BRaAHM4U+br6esxKvKRpIY350lm+Ii55Vd6vo=
Message-ID: <84144f02050706030846183451@mail.gmail.com>
Date: Wed, 6 Jul 2005 13:08:35 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [2/48] Suspend2 2.1.9.8 for 2.6.12: 300-reboot-handler-hook.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164392618@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164392618@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> diff -ruNp 301-proc-acpi-sleep-activate-hook.patch-old/drivers/acpi/sleep/proc.c 301-proc-acpi-sleep-activate-hook.patch-new/drivers/acpi/sleep/proc.c
> --- 301-proc-acpi-sleep-activate-hook.patch-old/drivers/acpi/sleep/proc.c       2005-06-20 11:46:50.000000000 +1000
> +++ 301-proc-acpi-sleep-activate-hook.patch-new/drivers/acpi/sleep/proc.c       2005-07-04 23:14:18.000000000 +1000
> @@ -68,6 +68,17 @@ acpi_system_write_sleep (
>                 goto Done;
>         }
>         state = simple_strtoul(str, NULL, 0);
> +#ifdef CONFIG_SUSPEND2
> +       /*
> +        * I used to put this after the CONFIG_SOFTWARE_SUSPEND
> +        * test, but people who compile in suspend2 usually want
> +        * to use it instead of swsusp.   --NC
> +        */
> +       if (state == 4) {

enum for states instead of magics, please.
