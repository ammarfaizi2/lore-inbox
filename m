Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUKJRDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUKJRDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 12:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUKJRDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 12:03:35 -0500
Received: from imap.gmx.net ([213.165.64.20]:25218 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262006AbUKJRDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 12:03:31 -0500
X-Authenticated: #21910825
Message-ID: <419249D8.1030100@gmx.net>
Date: Wed, 10 Nov 2004 18:03:20 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Robert Love <rml@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and vmalloc)
References: <4191A4E2.7040502@gmx.net> <1100066597.18601.124.camel@localhost> <20041110075450.GB5602@suse.de>
In-Reply-To: <20041110075450.GB5602@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Nov 10 2004, Robert Love wrote:
> 
>>On Wed, 2004-11-10 at 06:19 +0100, Carl-Daniel Hailfinger wrote:
>>
>>>it seems there is a bunch of drivers which want to allocate memory as
>>>efficiently as possible in a wide range of allocation sizes. XFS and
>>>NTFS seem to be examples. Implement a generic wrapper to reduce code
>>>duplication.
>>>Functions have the my_ prefixes to avoid name clash with XFS.
>>
>>No, no, no.  A good patch would be fixing places where you see this.
>>
>>Code needs to conscientiously decide to use vmalloc over kmalloc.  The
>>behavior is different and the choice needs to be explicit.
> 
> Plus, you cannot use vfree() from interrupt context. This patch is a bad
> idea.

OK, so how should I allocate memory for 512 struct loop_device's?
Because of its odd size (304 bytes) it seems that if I use kmalloc
seperately for each struct, I'd waste 208 bytes per allocation. 68%
overhead would be a step backwards. Or am I missing something here?


Regards,
Carl-Daniel
