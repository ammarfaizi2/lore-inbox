Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314387AbSDRQJP>; Thu, 18 Apr 2002 12:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314388AbSDRQJO>; Thu, 18 Apr 2002 12:09:14 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33545 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314387AbSDRQJO>;
	Thu, 18 Apr 2002 12:09:14 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables 
In-Reply-To: Your message of "Thu, 18 Apr 2002 16:52:29 +0100."
             <20020418165229.A16156@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Apr 2002 02:09:03 +1000
Message-ID: <3559.1019146143@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002 16:52:29 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Fri, Apr 19, 2002 at 01:38:59AM +1000, Keith Owens wrote:
>> For example, arm #defines get8_unaligned_check which uses __ex_table.
>
>This doesn't cause your issue though.  Its only used from code built into
>the kernel .text segment, never from any other segment.  It isn't a
>#define in some random header file that may end up in the .init segment
>either.

You are missing the point.  There are several macros that use
__ex_table.  Unless it can be guaranteed that no current or future use
of *any* of those macros will be in an __init section then we must not
assume that the exception table is sorted.

Exception table is not the only one that is assumed to be sorted,
get8_unaligned_check is not the only macro that uses __ex_table.  Both
are examples of tables and code where we assume, but do not validate, a
sorted table.

