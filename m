Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130111AbRACWN2>; Wed, 3 Jan 2001 17:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130338AbRACWNS>; Wed, 3 Jan 2001 17:13:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:59340 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130111AbRACWNJ>;
	Wed, 3 Jan 2001 17:13:09 -0500
Date: Wed, 3 Jan 2001 17:13:00 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dan Aloni <karrde@callisto.yi.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.21.0101040001170.21225-100000@callisto.yi.org>
Message-ID: <Pine.GSO.4.21.0101031704590.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Dan Aloni wrote:

> On Wed, 3 Jan 2001, Alexander Viro wrote:
> 
> > > This preliminary, small patch prevents execution of system calls which
> > > were executed from a writable segment. It was tested and seems to work,
> > > without breaking anything. It also reports of such calls by using printk.
> > 
> > Get real. Attacker can set whatever registers he needs and jump to one
> > of the many instances of int 0x80 in libc. There goes your protection.
> 
> But unlike syscalls, offsets inside libc do change. Aren't they?
> Programs don't have to use libc, they can be compiled as static.

Yes. And they will exit without system calls... how, exactly? Dumping core?
Libc or not, you _will_ have 0xcd 0x80 that can be executed. It's not like
searching for these two bytes was a problem, after all - several instructions
is all it takes.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
