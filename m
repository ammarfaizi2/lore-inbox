Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129902AbQLYFml>; Mon, 25 Dec 2000 00:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130010AbQLYFmc>; Mon, 25 Dec 2000 00:42:32 -0500
Received: from www.wen-online.de ([212.223.88.39]:9745 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129902AbQLYFmV>;
	Mon, 25 Dec 2000 00:42:21 -0500
Date: Mon, 25 Dec 2000 06:09:35 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Andreas Franck <afranck@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
In-Reply-To: <00122423490000.00575@dg1kfa.ampr.org>
Message-ID: <Pine.Linu.4.10.10012250531020.560-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Dec 2000, Andreas Franck wrote:

> Hello Mike, hello linux-kernel hackers,
> 
> Mike Galbraith wrote:
> 
> > Yes, hmm indeed.  Try these two things.
> > 
> > 1. make DECLARE_MUTEX_LOCKED(sem) in bdflush_init() static.
> > 2. compile with frame pointers.  (normal case for IKD)
> > 
> > My IKD tree works with either option, but not with neither.  I haven't
> > figured out why yet.
> 
> 1 worked for me, too - with the same effect as compiling buffer.c with 
> 2.95.2, thus meaning successful boot and heavy crashing later on. 
> I haven't tried to boot 2 yet, but this looks seriously fishy to me. It would 
> be nice if we could make a simpler testcase to reproduce it, as it's much 
> work to boot the kernel over and over again.

I wouldn't (not going to here;) spend a lot of time on it.  The compiler
has problems.  It won't build glibc-2.2, and chokes horribly on ipchains.

int ipt_register_table(struct ipt_table *table)
{
	int ret;
	struct ipt_table_info *newinfo;
	static struct ipt_table_info bootstrap
		= { 0, 0, { 0 }, { 0 }, { } };
                               ^
ip_tables.c:1361: Internal compiler error in array_size_for_constructor, at varasm.c:4456

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
