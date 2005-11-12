Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbVKLVtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVKLVtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVKLVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:49:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20923 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964820AbVKLVtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:49:06 -0500
Date: Sat, 12 Nov 2005 13:48:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: selhorst@crypto.rub.de, linux-kernel@vger.kernel.org,
       castet.matthieu@free.fr
Subject: Re: [PATCH] TPM: cleanups
Message-Id: <20051112134844.7f177e07.akpm@osdl.org>
In-Reply-To: <1131750533.5048.36.camel@localhost.localdomain>
References: <435FB8A5.803@crypto.rub.de>
	<435FBFC4.5060508@free.fr>
	<4360B889.1010502@crypto.rub.de>
	<1130422052.4839.134.camel@localhost.localdomain>
	<20051027145535.0741b647.akpm@osdl.org>
	<1131739863.5048.18.camel@localhost.localdomain>
	<1131750533.5048.36.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall <kjhall@us.ibm.com> wrote:
>
>  +	schedule_work(&chip->work);
>  +}
>  +
>  +static void timeout_work(void * ptr)
>  +{
>  +	struct tpm_chip *chip = (struct tpm_chip*) ptr;
>  +

I cannot see where the tpm driver stops that timer which it has running on
device close or on module unload.

Wherever it is, we'll now also need a flush_scheduled_work() to avoid a race
wherein the work handler is still executing while the module gets
unloaded.
