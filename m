Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbUCES3Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbUCES3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:29:25 -0500
Received: from hail.he.net ([64.62.223.2]:29115 "HELO hail.he.net")
	by vger.kernel.org with SMTP id S262192AbUCES3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:29:24 -0500
Message-ID: <4048C6B7.7080202@BitWagon.com>
Date: Fri, 05 Mar 2004 10:28:07 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike@navi.cx
CC: linux-kernel@vger.kernel.org
Subject: Re: Potential bug in fs/binfmt_elf.c?
References: <1078508281.3065.33.camel@linux.littlegreen>
In-Reply-To: <1078508281.3065.33.camel@linux.littlegreen>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When mapping a nobits PT_LOAD segment with a memsize > filesize, the
> kernel calls set_brk (which in turns calls do_brk) to map and clear the
> area, but this discards access permissons on the mapping leading to rwx
> protection. This causes a load failure on systems where the VM cannot
> reserve swap space for the segment, unless overcommit is active (on many
> systems it's not on by default).
[snip]

I believe that's not the only problem with binfmt_elf.  If the total address
space described by the PT_LOADs is not exactly one contiguous interval, then
2.6.3 binfmt_elf fills in the gaps with 'prw.' of zero-filled pages, instead
of the intended "holes" with no mapping at all between isolated PT_LOADs.
One example is  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=115913

-- 

