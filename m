Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbTDFVbw (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTDFVbw (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:31:52 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:61839 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263104AbTDFVbv (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 17:31:51 -0400
Date: Sun, 6 Apr 2003 17:42:51 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       <andrea@suse.de>, <mingo@elte.hu>, <hugh@veritas.com>,
       <dmccr@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Bill Irwin <wli@holomorphy.com>
Subject: Re: subobj-rmap
In-Reply-To: <1070000.1049664851@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0304061737510.2296-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, Martin J. Bligh wrote:

> Supposing we keep a list of areas (hung from the address_space) that 
> describes independant linear ranges of memory that have the same set
> of vma's mapping them (call those subobjects). Each subobject has a
> chain of vma's from it that are mapping that subobject.
> 
> address_space ---> subobject ---> subobject ---> subobject ---> subobject
>                        |              |              |              |
>                        v              v              v              v
>                       vma            vma            vma            vma
>                        |                             |              |
>                        v                             v              v
>                       vma                           vma            vma
>                        |                             |        
>                        v                             v        
>                       vma                           vma       

OK, lets say we have a file of 1000 pages, or
offsets 0 to 999, with the following mappings:

VMA A:   0-999
VMA B:   0-200
VMA C: 150-400
VMA D: 300-500
VMA E: 300-500
VMA F:   0-999

How would you describe these with independant
regions ?

For VMAs D & E and A & F it's a no-brainer,
but for Oracle shared memory you shouldn't
assume that you have any similar mappings.

I don't see how the data structure you describe
would allow us to efficiently select the subset
of VMAs for which:

1) the start address is smaller than the address we want
and
2) the end address is larger than the address we want

Then again, that might just be my lack of imagination.

cheers,

Rik

