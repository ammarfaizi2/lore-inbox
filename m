Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVC2PKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVC2PKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVC2PKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:10:22 -0500
Received: from admin.voldemort.codesourcery.com ([65.74.133.9]:44023 "EHLO
	mail.codesourcery.com") by vger.kernel.org with ESMTP
	id S262308AbVC2PIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:08:47 -0500
Message-ID: <42496F76.4010002@codesourcery.com>
Date: Tue, 29 Mar 2005 16:08:38 +0100
From: Nathan Sidwell <nathan@codesourcery.com>
Organization: Codesourcery LLC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: memcpy(a,b,CONST) is not inlined by gcc 3.4.1 in Linux kernel
References: <200503291737.06356.vda@ilport.com.ua>
In-Reply-To: <200503291737.06356.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> Disassembly of section .text:
> 

>    e:   e8 fc ff ff ff          call   f <f3+0xf>
>                         f: R_386_PC32   memcpy

> #define memcpy(t, f, n) \
> (__builtin_constant_p(n) ? \
>  __constant_memcpy((t),(f),(n)) : \
>  __memcpy((t),(f),(n)))

given this #define, how can 'memcpy' appear in the object file?  It appears
that something odd is happening with preprocessing.  Check the .i files are
as you expect. -dD and -E options will be helpful to you.

nathan

-- 
Nathan Sidwell    ::   http://www.codesourcery.com   ::     CodeSourcery LLC
nathan@codesourcery.com    ::     http://www.planetfall.pwp.blueyonder.co.uk

