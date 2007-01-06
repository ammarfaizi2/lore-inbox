Return-Path: <linux-kernel-owner+w=401wt.eu-S1751363AbXAFLqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXAFLqy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 06:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbXAFLqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 06:46:54 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:4432 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbXAFLqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 06:46:53 -0500
Message-ID: <459F8C25.3090102@xs4all.nl>
Date: Sat, 06 Jan 2007 12:46:45 +0100
From: Bauke Jan Douma <bjdouma@xs4all.nl>
Reply-To: bjdouma@xs4all.nl
Organization: a training zoo
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: "Cyrill V. Gorcunov" <gorcunov@gmail.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] qconf: fix SIGSEGV on empty menu items
References: <200701042106.37338.gorcunov@gmail.com> <Pine.LNX.4.64.0701060415130.12512@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701060415130.12512@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote on 06-01-07 04:20:

<snip>

> Thanks, but this is more complex than necessary.
> It simply lacks some initializers.

<snip>

> ---
> Index: linux-2.6/scripts/kconfig/qconf.cc
> ===================================================================
> --- linux-2.6.orig/scripts/kconfig/qconf.cc	2007-01-05 01:47:54.000000000 +0100
> +++ linux-2.6/scripts/kconfig/qconf.cc	2007-01-05 01:56:54.000000000 +0100
> @@ -915,7 +915,7 @@ void ConfigView::updateListAll(void)
>  }
>  
>  ConfigInfoView::ConfigInfoView(QWidget* parent, const char *name)
> -	: Parent(parent, name), menu(0)
> +	: Parent(parent, name), menu(0), sym(0)
>  {
>  	if (name) {
>  		configSettings->beginGroup(name);
> @@ -951,6 +951,7 @@ void ConfigInfoView::setInfo(struct menu
>  	if (menu == m)
>  		return;
>  	menu = m;
> +	sym = NULL;
>  	if (!menu)
>  		clear();
>  	else
> -

I can confirm that this patch squashed the segfault.

bjd


