Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLDW0D>; Mon, 4 Dec 2000 17:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130083AbQLDWZx>; Mon, 4 Dec 2000 17:25:53 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7953 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129226AbQLDWZi>;
	Mon, 4 Dec 2000 17:25:38 -0500
Date: Mon, 4 Dec 2000 21:53:34 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: John Meikle <linux@procom.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Using map_user_kiobuf()
Message-ID: <20001204215334.B9238@redhat.com>
In-Reply-To: <NEBBIIEABDPEIPKIJFDOEEAMDGAA.linux@procom.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <NEBBIIEABDPEIPKIJFDOEEAMDGAA.linux@procom.demon.co.uk>; from linux@procom.demon.co.uk on Thu, Nov 30, 2000 at 01:07:37PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 30, 2000 at 01:07:37PM -0000, John Meikle wrote:
> I have been experimenting with a module that returns data to either a user
> space programme or another module.  A memory area is passed in, and the data
> is written to it.  Because the memory may be allocated either by a module or
> a user programme, a kiobuf seemed a good way of representing it.  A layer
> converts user memory to a kiobuf using map_user_kiobuf().

There are a number of fixes pending for 2.4, and released for 2.2, but
nothing that would explain the sort of kernel corruption you are
reporting --- it sounds as if you are overrunning the end of the
kiobuf, but it's hard to know without seeing the real code.

> The code in the module (without validation and error checking) is:
> 
> int test_kiobuf(char* buf)
> {
>     struct kiobuf *iobuf;
>     int i;
> 
>     alloc_kiovec(1, &iobuf);
>     map_user_kiobuf(WRITE, iobuf, buf, TEST_SIZE);

Careful, you can't touch the buffer for a WRITE map.  The READ/WRITE
flag is from the point of view of the user, and user write() syscalls
don't touch the data in memory!  If you want to modify the user
buffer, you need to use READ instead.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
