Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWFHUKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWFHUKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWFHUKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:10:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:27093 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964967AbWFHUKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:10:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tiIyqjfGLV6lZrpq+BnvqfYwMxUkB/BoCy3Ksp7dB/cxTbc0jJjwTwTwCBr6j66dSdKnJZgT5DvIPM3ZkITTtSsmzl0l+rQpq7TDastQ0D4DajMI6BpaDf/R0tozgJvJImPKg5pK84r1A1Unvq5hXYt6b4Bu2p6S5OkUOEgGnE0=
Message-ID: <5c49b0ed0606081310q5771e8d1s55acef09b405922b@mail.gmail.com>
Date: Thu, 8 Jun 2006 13:10:11 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] mm: tracking dirty pages -v6
Cc: "Hugh Dickins" <hugh@veritas.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "David Howells" <dhowells@redhat.com>,
       "Christoph Lameter" <christoph@lameter.com>,
       "Martin Bligh" <mbligh@google.com>, "Nick Piggin" <npiggin@suse.de>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <1149770654.4408.71.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060525135534.20941.91650.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606062056540.1507@blonde.wat.veritas.com>
	 <1149770654.4408.71.camel@lappy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/06, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
>
> People expressed the need to track dirty pages in shared mappings.
>
> Linus outlined the general idea of doing that through making clean
> writable pages write-protected and taking the write fault.
>
> This patch does exactly that, it makes pages in a shared writable
> mapping write-protected. On write-fault the pages are marked dirty and
> made writable. When the pages get synced with their backing store, the
> write-protection is re-instated.

Does this mean that processes dirtying pages via mmap are now subject
to write throttling?  That could dramatically change the performance
for tasks with a working set larger than 10% of memory.

NATE
