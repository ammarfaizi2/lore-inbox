Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291718AbSBHTMe>; Fri, 8 Feb 2002 14:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291750AbSBHTMZ>; Fri, 8 Feb 2002 14:12:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38161 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291718AbSBHTMJ>; Fri, 8 Feb 2002 14:12:09 -0500
Date: Fri, 8 Feb 2002 11:11:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Martin Wirth <Martin.Wirth@dlr.de>, Robert Love <rml@tech9.net>,
        <linux-kernel@vger.kernel.org>, <mingo@elte.hu>, <haveblue@us.ibm.com>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C641EE9.9F31612E@zip.com.au>
Message-ID: <Pine.LNX.4.31.0202081110190.12981-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Andrew Morton wrote:
>
> Yesterday, Ingo said:
>
> > i think one example *could* be to turn inode->i_sem into a combi-lock. Eg.
> > generic_file_llseek() could use the spin variant.
> >
> > this is a real performance problem, i've seen scheduling storms in
> > dbench-type runs due to llseek taking the inode semaphore.

... so just make it a spinlock instead.

The semaphore is overkill, as the only thing we're really protecting is
one 64-bit access against other updates.

		Linus

