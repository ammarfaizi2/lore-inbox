Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVCZU7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVCZU7u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 15:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVCZU7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 15:59:50 -0500
Received: from hera.kernel.org ([209.128.68.125]:6295 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261265AbVCZU7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 15:59:44 -0500
Date: Sat, 26 Mar 2005 12:39:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andreas Arens <andras@t-online.de>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc2 - fix for CAN-2005-0794: Potential DOS in load_elf_library
Message-ID: <20050326153906.GA19501@logos.cnet>
References: <200503261314.01633.andras@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503261314.01633.andras@t-online.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 01:14:01PM +0100, Andreas Arens wrote:
> Hi Marcelo, Herbert,
> 
> I'm just reading the patch so don't know of any hidden side-effects which
> might cure it, but this clearly looks like a possibly deadlocking typo in 
> fs/binfmt_elf.c to me:
> >
> >-       while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
> >+       while (elf_phdata->p_type != PT_LOAD)
> >+               eppnt++;
> 
> Shouldn't this be:
> 
> -       while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
> +       while (eppnt->p_type != PT_LOAD)
> +               eppnt++;

Doh.

Yes, it is. I change it accordingly, will release another -rc :( 
