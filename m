Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278293AbRJWVHG>; Tue, 23 Oct 2001 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278295AbRJWVG5>; Tue, 23 Oct 2001 17:06:57 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43140 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278289AbRJWVGs>; Tue, 23 Oct 2001 17:06:48 -0400
Date: Tue, 23 Oct 2001 16:05:55 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Issue with max_threads (and other resources) and highmem
Message-ID: <91510000.1003871155@baldur>
In-Reply-To: <Pine.LNX.4.33L.0110231850100.3690-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0110231850100.3690-100000@imladris.surriel.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, October 23, 2001 18:52:35 -0200 Rik van Riel
<riel@conectiva.com.br> wrote:

> I submitted a patch a while ago to set the number way lower,
> which was accepted by Alan and in the -ac kernels. A few months
> later Linus followed and changed the limit in his kernels, too.

Ok, that's what I get for reading the comment and not deciphering the
code...  The actual calculation is mempages / (THREAD_SIZE/PAGE_SIZE) / 8
where THREAD_SIZE is 2 pages on i386.  If I read it right this means it's
limiting it to 1/8 physical memory instead of half.

But there's still a problem.  The value for mempages is all of physical
memory including highmem, so a machine with a sufficient amount of high
memory can set max_threads to a value way too high, given that most if not
all of the resources it's trying to limit have to come from normal memory
and not high memory.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

