Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265790AbUGAPBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265790AbUGAPBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 11:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUGAPBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 11:01:55 -0400
Received: from lakermmtao04.cox.net ([68.230.240.35]:60598 "EHLO
	lakermmtao04.cox.net") by vger.kernel.org with ESMTP
	id S265790AbUGAPBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 11:01:53 -0400
In-Reply-To: <20040701145004.GA5114@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com> <20040701041158.GE1564@mail.shareable.org> <736E7483-CB1B-11D8-947A-000393ACC76E@mac.com> <20040701123941.GC4187@mail.shareable.org> <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com> <20040701145004.GA5114@mail.shareable.org>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9628EAFE-CB6F-11D8-947A-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: lkml List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Testing PROT_NONE and other protections, and a surprise
Date: Thu, 1 Jul 2004 11:01:52 -0400
To: Jamie Lokier <jamie@shareable.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 01, 2004, at 10:50, Jamie Lokier wrote:
> Kyle Moffett wrote:
>>> The error code is -1, aka. MAP_FAILED.
>> Oops!  I guess I was just lucky that part didn't fail :-D On the
>> other hand, it couldn't legally return 0 anyway, could it?
>
> Yes it could -- if you request a mapping at address 0 with MAP_FIXED.
> A few OSes won't do that, but Linux and many others will.

That allows untrapped dereferencing of a NULL pointer.  IMHO, that
would be a very unintelligent thing for a program to do, to deny itself
the bug-catching features provided therein, but it's interesting to see
that it is possible.

#include <sys/types.h>
#include <sys/mman.h>

int main() {
	void *mem = mmap(0,4096,PROT_WRITE,MAP_FIXED|MAP_ANON|MAP_SHARED,-1,0);
	if (mem == MAP_FAILED) return 1;
	((long *)mem)[0] = 1;
	return 0;
}

Cheers,
Kyle Moffett

