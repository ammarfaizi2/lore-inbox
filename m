Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWGFJDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWGFJDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbWGFJDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:03:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8581 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965114AbWGFJDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:03:14 -0400
Date: Thu, 6 Jul 2006 02:02:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-Id: <20060706020257.1e9b621e.akpm@osdl.org>
In-Reply-To: <20060706082341.GB24492@elte.hu>
References: <20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
	<20060705131824.52fa20ec.akpm@osdl.org>
	<Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	<20060705204727.GA16615@elte.hu>
	<Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	<20060705214502.GA27597@elte.hu>
	<Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	<Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	<20060706082341.GB24492@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006 10:23:41 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> uninline more wait.h inline functions.
> 
> allyesconfig vmlinux size delta:
> 
>   text            data    bss     dec          filename
>   20736884        6073834 3075176 29885894     vmlinux.before
>   20721009        6073966 3075176 29870151     vmlinux.after

On my x86_64 typicalconfig
(http://www.zip.com.au/~akpm/linux/patches/stuff/config-x)


everything inlined:

   text    data     bss     dec     hex filename
4079169  702440  280184 5061793  4d3ca1 vmlinux

uninline init_waitqueue_head:

4076921  702456  280184 5059561  4d33e9 vmlinux

uninline init_waitqueue_head+init_waitqueue_entry

box:/usr/src/25> size vmlinux
   text    data     bss     dec     hex filename
4077017  702472  280184 5059673  4d3459 vmlinux

uninline init_waitqueue_head+init_waitqueue_entry+init_waitqueue_func_entry

box:/usr/src/25> size vmlinux
   text    data     bss     dec     hex filename
4077128  702496  280184 5059808  4d34e0 vmlinux


So we only want to uninline init_waitqueue_head().
