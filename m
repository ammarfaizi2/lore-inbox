Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSJVSbV>; Tue, 22 Oct 2002 14:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264816AbSJVSbV>; Tue, 22 Oct 2002 14:31:21 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:180 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264814AbSJVSbT>; Tue, 22 Oct 2002 14:31:19 -0400
Date: Tue, 22 Oct 2002 13:36:49 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@digeo.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <145460000.1035311809@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44L.0210221514430.1648-100000@duckman.distro.conectiva>
References: <Pine.LNX.4.44L.0210221514430.1648-100000@duckman.distro.conecti
 va>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, October 22, 2002 15:15:29 -0200 Rik van Riel
<riel@conectiva.com.br> wrote:

>> Or large pages.  I confess to being a little perplexed as to
>> why we're pursuing both.
> 
> I guess that's due to two things.
> 
> 1) shared pagetables can speed up fork()+exec() somewhat
> 
> 2) if we have two options that fix the Oracle problem,
>    there's a better chance of getting at least one of
>    the two merged ;)

And
  3) The current large page implementation is only for applications
     that want anonymous *non-pageable* shared memory.  Shared page
     tables reduce resource usage for any shared area that's mapped
     at a common address and is large enough to span entire pte pages.
     Since all pte pages are shared on a COW basis at fork time, children
     will continue to share all large read-only areas with their
     parent, eg large executables.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

