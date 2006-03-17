Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752469AbWCQAmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbWCQAmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbWCQAmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:42:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752462AbWCQAmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:42:44 -0500
Date: Thu, 16 Mar 2006 16:42:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Scott Bardone <sbardone@chelsio.com>
Subject: Re: [git patches] net driver fixes
In-Reply-To: <20060317003041.GA28029@havoc.gtf.org>
Message-ID: <Pine.LNX.4.64.0603161639450.3618@g5.osdl.org>
References: <20060317003041.GA28029@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Mar 2006, Jeff Garzik wrote:
>
> Please pull from 'upstream-fixes' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

The commit comments for the Chelsio driver fix are a bit unfortunate.

The array clearly _does_ have three elements, it's just that the code used 
to access the fourth (that didn't exist), and now it accesses the third.

So when the commit says "The array should contain 2 elements" it's just 
being really confused.

Of course, using an array index of "cmdQ_restarted[2]" without any 
explanation for why it's index 2, the bug was inevitable. Maybe a symbolic 
value for the magic array indices?

		Linus
