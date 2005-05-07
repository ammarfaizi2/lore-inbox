Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVEGR7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVEGR7l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 13:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVEGR7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 13:59:25 -0400
Received: from fisica.ufpr.br ([200.17.209.129]:30383 "EHLO fisica.ufpr.br")
	by vger.kernel.org with ESMTP id S262737AbVEGR7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 13:59:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <17021.486.683745.867241@fisica.ufpr.br>
Date: Sat, 7 May 2005 14:59:02 -0300
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck@vds.kolivas.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] implement nice support across physical cpus on SMP
In-Reply-To: <200505072342.32997.kernel@kolivas.org>
References: <200505072342.32997.kernel@kolivas.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: carlos@fisica.ufpr.br (Carlos Carvalho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas (kernel@kolivas.org) wrote on 7 May 2005 23:42:
 >SMP balancing is currently designed purely with throughput in mind. This 
 >working patch implements a mechanism for supporting 'nice' across physical 
 >cpus without impacting throughput.
 >
 >This is a version for stable kernel 2.6.11.*
 >
 >Carlos, if you could test this with your test case it would be appreciated.

Unfortunately it doesn't seem to have any effect:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  184 user1    39  19  7220 5924  520 R 99.9  1.1 209:40.68 mi41
  266 user2    25   0  1760  480  420 R 50.5  0.1  86:36.31 xdipole1
  227 user3    25   0  155m  62m  640 R 49.5 12.3  95:07.89 b170-se.x

Note that the nice 19 job monopolizes one processor while the other
two nice 0 ones share a single processor.

This is really a showstopper for this kind of application :-(
