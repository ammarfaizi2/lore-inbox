Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030713AbWKOREe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030713AbWKOREe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030714AbWKOREe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:04:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030713AbWKOREc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:04:32 -0500
Date: Wed, 15 Nov 2006 09:00:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, ext4 <linux-ext4@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: pagefault in generic_file_buffered_write() causing deadlock
Message-Id: <20061115090005.c9ec6db5.akpm@osdl.org>
In-Reply-To: <1163606265.7662.8.camel@dyn9047017100.beaverton.ibm.com>
References: <1163606265.7662.8.camel@dyn9047017100.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 07:57:45 -0800
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> We are looking at a customer situation (on 2.6.16-based distro) - where
> system becomes almost useless while running some java & stress tests.
> 
> Root cause seems to be taking a pagefault in generic_file_buffered_write
> () after calling prepare_write. I am wondering 
> 
> 1) Why & How this can happen - since we made sure to fault the user
> buffer before prepare write.

When using writev() we only fault in the first segment of the iovec.  If
the second or succesive segment isn't mapped into pagetables we're
vulnerable to the deadlock.

> 2) If this is already fixed in current mainline (I can't see how).

It was fixed in 2.6.17.

You'll need 6527c2bdf1f833cc18e8f42bd97973d583e4aa83 and
81b0c8713385ce1b1b9058e916edcf9561ad76d6
