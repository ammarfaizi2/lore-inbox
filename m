Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270358AbUJUEre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270358AbUJUEre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 00:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270430AbUJUErZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 00:47:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:4069 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270358AbUJUEn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 00:43:26 -0400
Date: Wed, 20 Oct 2004 21:36:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: andrea@novell.com, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-Id: <20041020213622.77afdd4a.akpm@osdl.org>
In-Reply-To: <417728B0.3070006@yahoo.com.au>
References: <20041021011714.GQ24619@dualathlon.random>
	<417728B0.3070006@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> >  #if defined(CONFIG_SMP)
>  >  struct zone_padding {
>  > -	int x;
>  >  } ____cacheline_maxaligned_in_smp;
>  >  #define ZONE_PADDING(name)	struct zone_padding name;
>  >  #else
> 
>  Perhaps to keep old compilers working? Not sure.

gcc-2.95 is OK with it.

Stock 2.6.9:

	sizeof(struct zone) = 1920

With Andrea's patch:

	sizeof(struct zone) = 1536

With ZONE_PADDING removed:

	sizeof(struct zone) = 1408
	
