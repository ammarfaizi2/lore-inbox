Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUBZFcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 00:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUBZFcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 00:32:17 -0500
Received: from fmr05.intel.com ([134.134.136.6]:60646 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262687AbUBZFcM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 00:32:12 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Intel vs AMD64
Date: Wed, 25 Feb 2004 21:32:08 -0800
Message-ID: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel vs AMD64
Thread-Index: AcP8IThQvuQD+eNEQiyq2lFbA4Z/lwABvoWg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <richard.brunner@amd.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Feb 2004 05:32:09.0225 (UTC) FILETIME=[E0D26790:01C3FC29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the clarification.

Yes, "implementation specific" is one of the differences between IA-32e
and AMD64, i.e. that behavior is architecturally defined on AMD64, but
on IA-32e (as I posted): 
  Near branch with 66H prefix:
    As documented in PRM the behavior is implementation specific and
should 
    avoid using 66H prefix on near branches.

Jun
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of richard.brunner@amd.com
>Sent: Wednesday, February 25, 2004 8:28 PM
>To: linux-kernel@vger.kernel.org
>Subject: RE: Intel vs AMD64
>
>Not sure about other architectures, but in the
>AMD64 architecture, the 66h and 67h prefixes
>can be applied to the near branch
>instructions and have an *architecturally*
>defined action (rather than implementation-defined
>action) which all AMD64 processors follow. It's all
>described in the AMD64 Architecture Programmer's
>Manuals ...
>
>(http://www.amd.com/us-
>en/Processors/DevelopWithAMD/0,,30_2252_739_7044,00.html)
>
>But, I definitely agree that it is sorta hard to figure
>out what a 64-bit general purpose compiler would
>actually *do* with some of them. However, there are
>embedded/special-purpose scenarios where this might
>be just fine.
>
>For example, for JMP (near):
>
>In 64-bit mode, if the JMP target is specified by a
>displacement in the instruction, the signed displacement is
>added to the rIP (of the following instruction), and the
>result is truncated to 16 or 64 bits depending on operand
>size. [rb: 64-bit is default, 66h forces 16-bit].  The
>signed displacement can be 8 bits, 16 bits, or 32 bits,
>depending on the opcode and the operand size.  [rb: 8-bit
>has its own opcode (EB); for the E9 opcode: 32-bit is
>default and 66h forces 16-bit].
>
>] -Rich ...
>] AMD Fellow
>] richard.brunner at amd com
>
>> -----Original Message-----
>> From: Nakajima, Jun [mailto:jun.nakajima@intel.com]
>> Sent: Wednesday, February 25, 2004 5:20 PM
>> To: H. Peter Anvin; Timothy Miller
>> Cc: linux-kernel@vger.kernel.org
>> Subject: RE: Intel vs AMD x86-64
>>
>> Yes, that's the very reason I said "useless for compilers." The way
>> IP/RIP is updated is different (and implementation specific) on those
>> processors if 66H is used with a near branch. For example, RIP may be
>> zero-extended to 64 bits (from IP), as you observed before.
>>
>> Jun
>> >-----Original Message-----
>> >From: H. Peter Anvin [mailto:hpa@zytor.com]
>> >Sent: Wednesday, February 25, 2004 4:14 PM
>> >To: Timothy Miller
>> >Cc: Nakajima, Jun; linux-kernel@vger.kernel.org
>> >Subject: Re: Intel vs AMD x86-64
>> >
>> >Timothy Miller wrote:
>> >>
>> >>
>> >> Nakajima, Jun wrote:
>> >>
>> >>> For near branches (CALL, RET, JCC, JCXZ, JMP, etc.), the operand
size
>is
>> >>> forced to 64 bits on both processors in 64-bit mode, basically
>meaning
>> >>> RIP is updated.
>> >>>
>> >>> Compilers would typically use a JMP short for "intraprocedural
jumps",
>> >>> which requires just an 8-bit displacement relative to RIP.
>> >>
>> >> I see.  It's too bad you can't have a 16-bit displacement.
>> >>
>> >> Ummm... so if 66H were used with a near branch, would that affect
the
>> >> size of the immediate operand which gets added to RIP, or would
that
>> >> affect the the portion of IP/EIP/RIP affected?  If it's the
latter,
>> >> that's pretty silly.
>> >>
>> >
>> >Yes, that would be pretty silly.
>> >
>> >I honestly don't remember off the top of my head what "o16 jmp blah"
>> >does on i386; I have a vague memory that it zero-extends %eip to 32
>> >bits, which makes it useless, of course.
>> >
>> >	-hpa
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
