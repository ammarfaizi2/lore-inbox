Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319081AbSH2DMe>; Wed, 28 Aug 2002 23:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319085AbSH2DMe>; Wed, 28 Aug 2002 23:12:34 -0400
Received: from dp.samba.org ([66.70.73.150]:26501 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319081AbSH2DMc>;
	Wed, 28 Aug 2002 23:12:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: junkio@cox.net
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1) 
In-reply-to: Your message of "Wed, 28 Aug 2002 14:31:31 MST."
             <200208282131.g7SLVVGx024191@siamese.dyndns.org> 
Date: Thu, 29 Aug 2002 13:09:05 +1000
Message-Id: <20020828221716.2C1D12C0E8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200208282131.g7SLVVGx024191@siamese.dyndns.org> you write:
> Here is a patch that does the same as what Keith Owens did in
> his patch recently.
> 
>     Message-ID: <fa.iks3ohv.1flge08@ifi.uio.no>
>     From: Keith Owens <kaos@ocs.com.au>
>     Subject: [patch] 2.4.19 Generate better code for nfs_sillyrename
>     Date: Wed, 28 Aug 2002 07:08:17 GMT
> 
>     Using strlen() generates an unnecessary inline function expansion plus
>     dynamic stack adjustment.  For constant strings, strlen() == sizeof()-1
>     and the object code is better.

Disagree.  If you really care make strlen use __builtin_constant_p().
Then authors don't have to sacrifice readability.

#define strlen(x) (__builtin_constant_p(x) ? sizeof(x)-1 : __strlen(x))

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
