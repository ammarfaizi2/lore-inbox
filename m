Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSGXM2o>; Wed, 24 Jul 2002 08:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSGXM2o>; Wed, 24 Jul 2002 08:28:44 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:10661 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317017AbSGXM2n>; Wed, 24 Jul 2002 08:28:43 -0400
Date: Wed, 24 Jul 2002 13:31:29 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: per-cpu data...
Message-ID: <20020724133128.A7192@kushida.apsleyroad.org>
References: <20020712062058.25F21415D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020712062058.25F21415D@lists.samba.org>; from rusty@rustcorp.com.au on Fri, Jul 12, 2002 at 04:01:52PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> (From my reading, ## on "int x" and "__per_cpu" is well-defined).

  DECLARE_PER_CPU (int x[3]);

doesn't work, although you can always do

  typedef int three_ints_t[3];
  DECLARE_PER_CPU (three_ints_t x);

I encountered the same thing while doing a user-space
`MAKE_THREAD_SPECIFIC' macro.  The solution I went for looks like this:

  #define DECLARE_PER_CPU(type, name) \
    __attribute__ ((__section (".percpu"))) __typeof__ (type) name##__per_cpu

enjoy,
-- Jamie
