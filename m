Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWAZALL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWAZALL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWAZALL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:11:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:25506 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751259AbWAZALK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:11:10 -0500
Date: Thu, 26 Jan 2006 01:11:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [patch, lock validator] fix proc_inum_lock related deadlock
Message-ID: <20060126001141.GA18181@elte.hu>
References: <20060125170331.GA29339@elte.hu> <1138209283.6695.55.camel@localhost.localdomain> <20060125180811.GA12762@elte.hu> <20060125102351.28cd52b8.akpm@osdl.org> <20060126000200.GA12809@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126000200.GA12809@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> there's another VFS lock that just popped up, hopefully the last one.  
> Fix below. (All this is still related to proc_subdir_lock, and the 
> original BKL bug it fixed.)

bah. proc_num_idr.lock nests too ...

i guess we should stick this into free_irq():

	WARN_ON(in_interrupt());

and be done with it. If all such places are fixed then Steve's fix 
becomes complete.

	Ingo
