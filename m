Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUKJGb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUKJGb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 01:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbUKJGb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 01:31:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:39646 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261904AbUKJGb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 01:31:56 -0500
X-Authenticated: #21910825
Message-ID: <4191B5D8.3090700@gmx.net>
Date: Wed, 10 Nov 2004 07:31:52 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and	vmalloc)
References: <4191A4E2.7040502@gmx.net> <1100066597.18601.124.camel@localhost>
In-Reply-To: <1100066597.18601.124.camel@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love schrieb:
> On Wed, 2004-11-10 at 06:19 +0100, Carl-Daniel Hailfinger wrote:
> 
>>Hi,
>>
>>it seems there is a bunch of drivers which want to allocate memory as
>>efficiently as possible in a wide range of allocation sizes. XFS and
>>NTFS seem to be examples. Implement a generic wrapper to reduce code
>>duplication.
>>Functions have the my_ prefixes to avoid name clash with XFS.
> 
> 
> No, no, no.  A good patch would be fixing places where you see this.
> 
> Code needs to conscientiously decide to use vmalloc over kmalloc.  The
> behavior is different and the choice needs to be explicit.

Yes, but what do you suggest for the following problem:
alloc(max_loop*sizeof(struct loop_device))

where sizeof(struct loop_device)==304 and 1<=max_loop<=16384

For the smallest allocation (304 bytes) vmalloc is clearly wasteful
and for the largest allocation (~ 5 MBytes) kmalloc doesn't work.


Regards,
Carl-Daniel
