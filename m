Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266045AbUA2BfZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 20:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUA2BfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 20:35:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7431 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S266045AbUA2BfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 20:35:17 -0500
Message-ID: <40186338.3010005@zytor.com>
Date: Wed, 28 Jan 2004 17:34:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
CC: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: long long on 32-bit machines
References: <200401282051.VAA07809@faui1d.informatik.uni-erlangen.de>
In-Reply-To: <200401282051.VAA07809@faui1d.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Weigand wrote:
> Arnd Bergmann wrote:
> 
> 
>>Some architectures require long long arguments to be passed as an
>>even/odd register pair. For example on s390, 
>>
>>  void f(int a, int b, long long x) 
>>
>>uses registers 2, 3, 4 and 5, while 
>>
>>  void f(int a, long long x, int b)
>>
>>uses registers 2, 4, 5 and 6.
> 
> 
> Actually, this isn't quite true -- the second case will also
> use registers 2, 3, 4, and 5.
> 
> However, there is still a case where a single long long is
> passed differently from a pair of longs: when there is only
> a single register remaining for parameters.
> 
> This means that
>   void f(int a, int b, int c, int d, long e, long f)
> is passed as
>   a-d in register 2-5
>   e in register 6
>   f on the stack (4 bytes)
> 
> while
>   void f(int a, int b, int c, int d, long long e)
> is passed as
>   a-d in register 2-5
>   nothing in register 6
>   e on the stack (8 bytes)
>  

If I remember correctly, a 6-argument system call on s390 will put a
pointer to the last two arguments as the effective 5th argument, so this
would not affect the system call calling convention, correct?

	-hpa

