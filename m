Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTEBQgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbTEBQgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:36:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63928 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262985AbTEBQgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:36:46 -0400
Message-ID: <3EB2A125.4000407@us.ibm.com>
Date: Fri, 02 May 2003 09:47:33 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
References: <20030502020149.1ec3e54f.akpm@digeo.com> <20030502131857.GH8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> On Fri, May 02, 2003 at 02:01:49AM -0700, Andrew Morton wrote:
>>+dont-set-kernel-pgd-on-PAE.patch
>> little ia32 optimisation/cleanup
> 
> It looks like no one listened to my commentary on the set_pgd() patch.
> 
> Remove pointless #ifdef, pointless set_pgd(), and a mysterious line
> full of nothing but whitespace after the #endif, and update commentary.
> -#ifndef CONFIG_X86_PAE
> -		set_pgd(pgd, *pgd_k);
> -#endif

I wask thinking that the PMD set in 4G mode was a noop.  But, it isn't,
so it makes up for the completely removed pgd set.

This comment needs to get updated in include/asm-i386/pgtable-2level.h:
/*
 * (pmds are folded into pgds so this doesn't get actually called,
 * but the define is needed for a generic inline function.)
 */
#define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
#define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)

-- 
Dave Hansen
haveblue@us.ibm.com

