Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbTDFDML (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 22:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbTDFDMK (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 22:12:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:55455 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262778AbTDFDMK (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 22:12:10 -0500
Date: Sat, 05 Apr 2003 19:23:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, andrea@suse.de, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <72740000.1049599406@[10.10.2.4]>
In-Reply-To: <20030405040614.66511e1e.akpm@digeo.com>
References: <20030404163154.77f19d9e.akpm@digeo.com><12880000.1049508832@flay><20030405024414.GP16293@dualathlon.random><20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The first test has 100 tasks, each of which has 100 vma's.  The 100 processes
> modify their 100 vma's in a linear walk.  Total working set is 240MB
> (slightly more than is available).
> 
> 	./rmap-test -l -i 10 -n 100 -s 600 -t 100 foo
> 
> 2.5.66-mm4:
> 	15.76s user 86.91s system 33% cpu 5:05.07 total
> 2.5.66-mm4+objrmap:
> 	23.07s user 1143.26s system 87% cpu 22:09.81 total
> 2.4.21-pre5aa2:
> 	14.91s user 75.30s system 24% cpu 6:15.84 total

Isn't the intent to use sys_remap_file_pages for these sort of workloads
anyway? In which case partial objrmap = rmap for these tests, so we're
still OK?

M.

