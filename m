Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267464AbRGLKOy>; Thu, 12 Jul 2001 06:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267465AbRGLKOo>; Thu, 12 Jul 2001 06:14:44 -0400
Received: from ns.suse.de ([213.95.15.193]:6419 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267464AbRGLKOb>;
	Thu, 12 Jul 2001 06:14:31 -0400
To: llarsh@oracle.com
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com.suse.lists.linux.kernel>
From: Andi Kleen <freitag@alancoxonachip.com>
Date: 12 Jul 2001 12:14:16 +0200
In-Reply-To: Lance Larsh's message of "12 Jul 2001 00:58:14 +0200"
Message-ID: <oup8zhue9on.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lance Larsh <llarsh@oracle.com> writes:
> 
> I ran lots of iozone tests which illustrated a huge difference in write
> throughput between reiser and ext2.  Chris Mason sent me a patch which
> improved the reiser case (removing an unnecessary commit), but it was
> still noticeably slower than ext2.  Therefore I would recommend that
> at this time reiser should not be used for Oracle database files.

When I read the 2.4.6 reiserfs code correctly reiserfs does not cause
any transactions for reads/writes to allocated blocks; i.e. you're not extending
the file, you're not filling holes and you're not updating atimes.
My understanding is that this is normally true for Oracle, but probably
not for iozone so it would be better if you benchmarked random writes
to an already allocated file. 
The 2.4 page cache is more or less direct write through in this case.

-Andi
