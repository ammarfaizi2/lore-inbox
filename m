Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSJVWub>; Tue, 22 Oct 2002 18:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbSJVWub>; Tue, 22 Oct 2002 18:50:31 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:7185 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261645AbSJVWua>;
	Tue, 22 Oct 2002 18:50:30 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Piet Delaney <piet@www.piet.net>
Cc: Christoph Hellwig <hch@sgi.com>, "Matt D. Robinson" <yakker@aparity.com>,
       linux-kernel@vger.kernel.org, steiner@sgi.com, jeremy@sgi.com
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files 
In-reply-to: Your message of "22 Oct 2002 15:21:02 MST."
             <1035325262.6847.23.camel@www.piet.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 Oct 2002 08:56:18 +1000
Message-ID: <15606.1035327378@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Oct 2002 15:21:02 -0700, 
Piet Delaney <piet@www.piet.net> wrote:
>Looks like your right, for parisc even these functions are using a
>spinlock. Is it really necessary for parisc to use spinlocks? Even
>Solaris doesn't use spinlocks for atomic set and reads of atomic
>variables.

Hardware restriction.  Somebody read that "all locks can be implemented
in terms of a single hardware primitive" and believed it :(.  The only
atomic operation on parisc is load and clear word.  According to the
comments in asm-parisc/atomic.h, atomic_set should not require a lock,
but it is coded to use one.  Atomic add/sub obviously needs a lock.

