Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWCFGiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWCFGiG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 01:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWCFGiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 01:38:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42981 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751352AbWCFGiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 01:38:05 -0500
Date: Sun, 5 Mar 2006 22:36:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Latchesar Ionkov <lucho@ionkov.net>
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] v9fs: print 9p messages
Message-Id: <20060305223623.1deb25a4.akpm@osdl.org>
In-Reply-To: <20060304152513.GA24046@ionkov.net>
References: <20060304152513.GA24046@ionkov.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latchesar Ionkov <lucho@ionkov.net> wrote:
>
> Print 9p messages.
> 
> ...
>
> +#define DEBUG_FCALL		(1<<8)
>  
> ..
>
> +	if ((v9fs_debug_level&DEBUG_FCALL) == DEBUG_FCALL) {

There's no point in the rhs of this comparison.  Given that DEBUG_FCALL is
a single bit and that won't be changing, one may as well do

	if (v9fs_debug_level & DEBUG_FCALL) {

Also, those macro names:

#define DEBUG_ERROR		(1<<0)
#define DEBUG_CURRENT		(1<<1)
#define DEBUG_9P	        (1<<2)
#define DEBUG_VFS	        (1<<3)
#define DEBUG_CONV		(1<<4)
#define DEBUG_MUX		(1<<5)
#define DEBUG_TRANS		(1<<6)
#define DEBUG_SLABS	      	(1<<7)
#define DEBUG_FCALL		(1<<8)

are quite poorly chosen.  If someone else were to make a similarly poor
naming choice there would be collisions.
