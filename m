Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUA1UvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbUA1UvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:51:12 -0500
Received: from faui10.informatik.uni-erlangen.de ([131.188.31.10]:4596 "EHLO
	faui10.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S266124AbUA1UvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:51:08 -0500
From: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Message-Id: <200401282051.VAA07809@faui1d.informatik.uni-erlangen.de>
Subject: Re: long long on 32-bit machines
To: hpa@zytor.com, arnd@arndb.de
Date: Wed, 28 Jan 2004 21:51:06 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

>Some architectures require long long arguments to be passed as an
>even/odd register pair. For example on s390, 
>
>   void f(int a, int b, long long x) 
>
>uses registers 2, 3, 4 and 5, while 
>
>   void f(int a, long long x, int b)
>
>uses registers 2, 4, 5 and 6.

Actually, this isn't quite true -- the second case will also
use registers 2, 3, 4, and 5.

However, there is still a case where a single long long is
passed differently from a pair of longs: when there is only
a single register remaining for parameters.

This means that
  void f(int a, int b, int c, int d, long e, long f)
is passed as
  a-d in register 2-5
  e in register 6
  f on the stack (4 bytes)

while
  void f(int a, int b, int c, int d, long long e)
is passed as
  a-d in register 2-5
  nothing in register 6
  e on the stack (8 bytes)
 
Bye,
Ulrich 

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
