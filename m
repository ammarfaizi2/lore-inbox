Return-Path: <linux-kernel-owner+w=401wt.eu-S964982AbWLTUwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWLTUwX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWLTUwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:52:23 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:58794 "EHLO
	liaag2aa.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964982AbWLTUwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:52:22 -0500
Date: Wed, 20 Dec 2006 15:48:27 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops in 2.6.19.1
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200612201550_MC3-1-D5C7-74C6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200612201421.03514.s0348365@sms.ed.ac.uk>

On Wed, 20 Dec 2006 14:21:03 +0000, Alistair John Strachan wrote:

> Any ideas?
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 
> 00000009

    83 ca 10                  or     $0x10,%edx
    3b                        .byte 0x3b
    87 68 01                  xchg   %ebp,0x1(%eax)   <=====
    00 00                     add    %al,(%eax)

Somehow it is trying to execute code in the middle of an instruction.
That almost never works, even when the resulting fragment is a legal
opcode. :)

The real instruction is:

    3b 87 68 01 00 00 00        cmp    0x168(%edi),%eax

I'd guess you have some kind of hardware problem.  It could also be
a kernel problem where the saved address was corrupted during an
interrupt, but that's not likely.
-- 
MBTI: IXTP
