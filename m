Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWBAKlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWBAKlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWBAKlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:41:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:49287 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932408AbWBAKle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:41:34 -0500
Message-ID: <43E0904C.1020201@sgi.com>
Date: Wed, 01 Feb 2006 11:41:16 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [patch] SGIIOC4 limit request size
References: <yq0vevzpi8r.fsf@jaguar.mkp.net> <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com>
In-Reply-To: <58cb370e0602010234p62521a00h6d8920c84cac44d5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On 01 Feb 2006 03:59:16 -0500, Jes Sorensen <jes@sgi.com> wrote:
>>This one takes care of a problem with the SGI IOC4 driver where it
>>hits DMA problems if the request grows too large.
> 
> 
> Does this happen only for CONFIG_IA64_PAGE_SIZE_4KB=y
> or CONFIG_IA64_PAGE_SIZE_8KB=y?
> 
> from sgiioc4.c:
> 
> /* Each Physical Region Descriptor Entry size is 16 bytes (2 * 64 bits) */
> /* IOC4 has only 1 IDE channel */
> #define IOC4_PRD_BYTES       16
> #define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))
> 
> As limiting request size to 127 sectors punishes performance
> wouldn't it be better to define IOC4_PRD_ENTRIES to 256
> if this is possible (would need 4 pages for PAGE_SIZE=4096
> and 2 for PAGE_SIZE=8192)?

This happens with the default page size which is 16KB, ie.
IOC4_PRD_ENTRIES=256, the problem is not due to the request
going beyond the number of PRD_ENTRIES. I haven't tried with smaller
page sizes but I would assume the problem would be the same.

Even with this patch performance seems very reasonable.

Jes
