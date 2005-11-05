Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbVKEHaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbVKEHaH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVKEHaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:30:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31409 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751336AbVKEHaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:30:05 -0500
Date: Fri, 4 Nov 2005 23:29:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fix remaining missing includes
Message-Id: <20051104232954.6145d309.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511041746470.4856@gans.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0511041746470.4856@gans.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
>
>  /* Encode and de-code a swap entry */
>  @@ -464,6 +464,7 @@ static inline int ptep_test_and_clear_di
>   
>   extern spinlock_t pa_dbit_lock;
>   
>  +struct mm_struct;

Generally, it's better to put these forward struct declarations right at
the top of the header file (after the nested includes).

Because if someone comes along later and adds some code which uses
mm_struct at line 300, he's going to say a rude word and then add a second
forward declaration at line 299, and we end up with two of them.  Or he's
more awake and he just moves your declaration.  Either way, putting it at
the top of the file eliminates the problem.

A followup patch sometime would be nice..
