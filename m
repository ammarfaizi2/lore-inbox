Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318025AbSGLWJs>; Fri, 12 Jul 2002 18:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318028AbSGLWJs>; Fri, 12 Jul 2002 18:09:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:62458 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318025AbSGLWJr>; Fri, 12 Jul 2002 18:09:47 -0400
Subject: Re: 64 bit netdev stats counter
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: matts@ksu.edu, shemminger@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020712.145835.91443486.davem@redhat.com>
References: <1026503694.26819.4.camel@dell_ss3.pdx.osdl.net>
	<Pine.GSO.4.33L.0207121628100.19313-100000@unix2.cc.ksu.edu> 
	<20020712.145835.91443486.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Jul 2002 00:20:53 +0100
Message-Id: <1026516053.9958.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-12 at 22:58, David S. Miller wrote:
> 32-bit values aren't atomic either, what is the issue?
> We don't use atomic_t ops on these counters so they aren't
> guarenteed in any way right now even.  GCC is going to
> output "incl MEM" or similar for net_stats->counter++, since
> it lacks the 'lock;' prefix it is not atomic.

The behaviour is quite different though. On a 32bit counter the worst we
do is lose a few counts. On a 64bit one on 32bit cpus its quite likely
gcc will output

		increment low 32bit
		if zero
			increment high

Which means we can rapidly get 2^32 out of sync

