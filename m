Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318949AbSICVqZ>; Tue, 3 Sep 2002 17:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSICVqY>; Tue, 3 Sep 2002 17:46:24 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:40199 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318949AbSICVqW>; Tue, 3 Sep 2002 17:46:22 -0400
Message-ID: <3D752E38.EF352F48@zip.com.au>
Date: Tue, 03 Sep 2002 14:48:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rasmus Andersen <rasmus@jaquet.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: __func__ in 2.5.33?
References: <20020903225229.A24108@jaquet.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen wrote:
> 
> Hi,
> 
> I trying to compile the SX driver for the 2.5.33 kernel, I got a
> lot of warnings looking like (this is from a test program, not
> the driver itself)
> 
> test.c: In function `main':
> test.c:6: called object is not a function
> test.c:6: parse error before string constant
> 
> This seems to stem from the recent __FUNCTION__ vs. __func__
> change in kernel.h and the SX driver's use of __FUNCTION__ in the
> following construct
> 
> #define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter " __FUNCTION__ "\n")
> 

The parenthesised (__func__) is there to force you to not try to
perform this string pasting.  Support for __FUNCTION__ pasting is
being phased out of gcc.

You need:

#define func_enter() sx_dprintk (SX_DEBUG_FLOW, "sx: enter %s\n", __FUNCTION__)
