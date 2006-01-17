Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWAQSDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWAQSDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWAQSDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:03:48 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:15190 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932150AbWAQSDr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:03:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T34R6iJPMRaPkfwkvWDYCAwAXxLMAiYCgRezXizTavdGN30znYPjX3oANdmWh3T5CJOEu8AuWn6CKXFGIu+GI0DPdZjZMyUSqza57PyJ1WJjdE23VThEqz5NNhIeC4nzllvAkjGQp2U6et9RWgBH0M1+/QhSaLPyhdXQOGTroMc=
Message-ID: <58cb370e0601171003q3e629131y115b665a93d083f3@mail.gmail.com>
Date: Tue, 17 Jan 2006 19:03:45 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: SBC EPX does not check/claim I/O ports it uses
Cc: calin@ajvar.org, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1137520351.14135.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1137520351.14135.40.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> @@ -180,6 +181,9 @@
>  static int __init watchdog_init(void)
>  {
>         int ret;
> +
> +       if (!request_region(EPXC3_WATCHDOG_CTL_REG, 2, "epxc3_watchdog"))
> +               return -EBUSY;
>
>         ret = register_reboot_notifier(&epx_c3_notifier);
>         if (ret) {

Shouldn't resource be released when
register_reboot_notifier() or misc_register() fails?

Bartlomiej
