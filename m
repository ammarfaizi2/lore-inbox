Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTIITfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbTIITfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:35:16 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:21223 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S264353AbTIITfF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:35:05 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [Patch] asm workarounds in generic header files
Date: Tue, 9 Sep 2003 12:34:56 -0700
Message-ID: <A609E6D693908E4697BF8BB87E76A07A022114C0@fmsmsx408.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] asm workarounds in generic header files
Thread-Index: AcN2nWCaheacrtpkTP+pVNRjvC6baQAasFJg
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Christoph Hellwig" <hch@infradead.org>,
       "Jes Sorensen" <jes@wildopensource.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 09 Sep 2003 19:34:56.0737 (UTC) FILETIME=[732EE510:01C37709]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jes and Christoph for your comments. As you have noticed, 
this patch is not a workaround/hack for any C standard violation. 

We believe that we are trying to improve the code by localizing 
the compiler issues (including the ones for gcc3 and Intel complier)
and by introducing use of compiler intrinsics (e.g. for barrier()).

> Could you try to test your RELOC_HIDE version with various 
> gcc versions
> and maybe as some gcc gurus whether it's fine?  

RELOC_HIDE is handling a specific gcc version behaviour. 
There was a discussion on this sometime back
http://gcc.gnu.org/ml/gcc/2002-01/msg00484.html

Richard Henderson mentioned that asm stmt is the only escape 
hitch for the current compiler behaviour. But as Linus suggested 
in the above mail thread, non-same-type cast(which is the current 
solution for Intel compiler) is the way to go for gcc also.

As far as barrier() is concerned, a cleaner approach would be  
a compiler-specific intrinsic(something like the one implemented by  
Intel compiler) that can tell the programmer's intention explicitly.

Once gcc has a cleaner solution for both these macros, we can 
do-away with these changes.

thanks,
suresh
