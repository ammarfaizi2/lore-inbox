Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTGBW5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTGBW4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:56:01 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8446 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265453AbTGBWyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:54:23 -0400
Date: Wed, 02 Jul 2003 15:57:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Yet another SDET hang (73-mm3) ... yawn
Message-ID: <575880000.1057186633@flay>
In-Reply-To: <20030702155330.7d879299.akpm@digeo.com>
References: <570860000.1057184743@flay> <20030702155330.7d879299.akpm@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, July 02, 2003 15:53:30 -0700 Andrew Morton <akpm@digeo.com> wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> 2.5.73-mm3 + feral + highpte (ext2)
>> 
>> Seems to be all wedged up on io_schedule. Not sure if it was
>> highpte that caused this or not, but I'd done one run on ext2
>> and one on ext3 without it, and they worked fine.
> 
> highpte, or highpmd?
> 
> I assume the latter.  But either way, it would be an odd correlation.

The former, I think. I turned on "3rd level pagetables in high memory". Presumably that's still just highpte.

larry:~/linux/2.5.73-mm3# grep HIGH .config
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_DEBUG_HIGHMEM is not set

But yes, it's probably coincidence.

> It looks more like the block layer or device driver blew a fuse.  The usual
> deal: make it repeatable, then try `elevator=deadline', then try a
> different driver..

Yeah, I'll beat her some more later.

> Oh, and write OpenSDET while you're at it.  grr.

Use reaim7. But maybe I should write open-16-way-hardware with a
subtext of race-conditions-we-find? ;-)

M.

