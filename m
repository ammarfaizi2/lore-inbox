Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUAACS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 21:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUAACSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 21:18:25 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:57018 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S265326AbUAACSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 21:18:24 -0500
Message-ID: <3FF38375.2090808@metaparadigm.com>
Date: Thu, 01 Jan 2004 10:18:29 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: rudi@lambda-computing.de, ivern@acm.org, linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <3FF2FC85.5070906@lambda-computing.de> <3FF31366.30206@acm.org> <3FF31A15.4070307@lambda-computing.de> <3FF377A8.6040302@metaparadigm.com> <20040101015809.GA14930@redhat.com>
In-Reply-To: <20040101015809.GA14930@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/01/04 09:58, Dave Jones wrote:
> On Thu, Jan 01, 2004 at 09:28:08AM +0800, Michael Clark wrote:
>  > Have you had a look at dazuko. It provides a consistent file access
>  > notification mechanism (and also intervention for denying access) across
>  > linux and freebsd. It is currently being used by various on-access
>  > virus scanners. It is under active development and supports 2.6 (and 2.4)
> 
> Candidate for "Wackiest sys_call_table patching 2004".
> In a word "ick". Code not to be read on a full stomach.

Oh well, hadn't read the kernel code yet. Although certainly the *goal* is
a good one - a cross platform interface for file change notification.

Yes I see what you mean after having a look. Would make sense to convert
this over to use only LSM hooks (which it appears to use already) if that
was possible - or maybe could be done using a VFS proxy filesystem that
monitors/relays calls to an underlying fs.

The userspace interface appears relatively sane with its chardev interface
although due to it's ability to intervene on file access, it creates a
single point of failure that can livelock the machine if the userspace
monitoring proccess dies. This could be worked around if the poilicy
was to go unmonitored in the case that the userspace process dies.

~mc

