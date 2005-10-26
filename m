Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVJZHKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVJZHKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 03:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVJZHKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 03:10:10 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:14016 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932566AbVJZHKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 03:10:09 -0400
Date: Wed, 26 Oct 2005 10:57:09 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
Subject: Re: [PATCH 01/02] Export Connector Symbol
Message-ID: <20051026065709.GA19438@2ka.mipt.ru>
References: <1130285260.10680.194.camel@stark> <1130285785.10680.205.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1130285785.10680.205.camel@stark>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 26 Oct 2005 10:58:52 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 05:16:25PM -0700, Matt Helsley (matthltc@us.ibm.com) wrote:
>         The Process Events Connector uses this symbol to determine if it
> should respond to commands from userspace. However the it fails to link
> without the EXPORT_SYMBOL_GPL() macro.
> 
> Signed-Off-By: Matt Helsley <matthltc @ us.ibm.com> 

cn_already_initialized is only usefull for cases when 
both connector users and connector itself are compiled 
statically and connector users can generate events 
before connector is initialized. But in this case you do not 
need to export this symbol.

But if you bound your own events to this flag
I have no problem with this change.


> --
> 
> Resent with the subject line fixed.
> 
> ---
> 
> Index: linux-2.6.14-rc4/drivers/connector/connector.c
> ===================================================================
> --- linux-2.6.14-rc4.orig/drivers/connector/connector.c
> +++ linux-2.6.14-rc4/drivers/connector/connector.c
> @@ -45,10 +45,11 @@ static DECLARE_MUTEX(notify_lock);
>  static LIST_HEAD(notify_list);
>  
>  static struct cn_dev cdev;
>  
>  int cn_already_initialized = 0;
> +EXPORT_SYMBOL_GPL(cn_already_initialized);
>  
>  /*
>   * msg->seq and msg->ack are used to determine message genealogy.
>   * When someone sends message it puts there locally unique sequence
>   * and random acknowledge numbers.  Sequence number may be copied into
> 

-- 
	Evgeniy Polyakov
