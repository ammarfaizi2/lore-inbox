Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRDFHbj>; Fri, 6 Apr 2001 03:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRDFHba>; Fri, 6 Apr 2001 03:31:30 -0400
Received: from [202.54.26.202] ([202.54.26.202]:64479 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S131323AbRDFHbP>;
	Fri, 6 Apr 2001 03:31:15 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A26.0027EA80.00@sandesh.hss.hns.com>
Date: Fri, 6 Apr 2001 12:53:10 +0530
Subject: __switch_to macro
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
     The note above __switch_to macro in i386/kernel/process.c says that we no
more use hardware context switching as some problems in recovering from
saved state that is no longer valid. (I am peeking into 2.2 kernel). Now I have
following questions

1) What exactly is meant by ' stale segment register values' in the note.
2) In the above macro, I think we recover gracefully from error condition while
recovering fs and gs segment registers . The loadsegment(fs,next->tss.fs) and
loadsegment(gs,next->tss.gs) does it. I am not able to understand loadsegment
macro. The macro is as under

/** Load a segment. Fall back on loading a zero segment if something goes wrong
**/
#define loadsegment(seg,value)           \
     asm volatile("\n"             \
          "1:\t"                   \
          "movl %0,%%" #seg "\n"   \
          "2:\n"                   \
          "3:\t"                   \
          "pushl $0\n\t"           \
          "jmp 2b\n"               \
          ".previous\n"            \
          ".section __ex_table,\"a\"\n\t  \
          "/align 4\n\t"           \
          ".long 1b,3b\n"          \
          ".previous"              \
          : :"m" (*(unsigned int *)&(value)))

I also want to know what is 'something' in the comment above the macro

Thanks in advance
Amol






