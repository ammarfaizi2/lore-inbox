Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbWHIKSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbWHIKSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030650AbWHIKSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:18:41 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:22702 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1030589AbWHIKSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:18:39 -0400
Message-ID: <44D9A86F.3010304@namesys.com>
Date: Wed, 09 Aug 2006 03:18:39 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Alexander Zarochentsev <zam@namesys.com>, Andrew Morton <akpm@osdl.org>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: partial reiser4 review comments
References: <20060803001741.4ee9ff72.akpm@osdl.org> <20060803142644.GC20405@infradead.org> <200608061838.35004.zam@namesys.com> <20060809085946.GA6177@infradead.org>
In-Reply-To: <20060809085946.GA6177@infradead.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> I must admit that standalone code snipplet doesn't really tell me a lot.
>
>Do you mean the possibility to pass around a filesystem-defined structure
>to multiple allocator calls?  I'm pretty sure can add that, I though it
>would be useful multiple times in the past but always found ways around
>it.
>
>  
>
Assuming I understand your discussion, I see two ways to go, one is to
pass around fs specific state and continue to call into the FS many
times, and the other is to instead provide the fs with helper functions
that accomplish readahead calculation, page allocation, etc., and let
the FS keep its state naturally without having to preserve it in some fs
defined structure.  The second approach would be cleaner code design,
that would also ease cross-os porting of filesystems, in my view.

As a philosophy of design issue, the current VFS and generic code leaves
me with the feeling that people are trying to write the FS rather than
trying to help the FS writer with some useful library functions.
