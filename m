Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAINye>; Tue, 9 Jan 2001 08:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAINyR>; Tue, 9 Jan 2001 08:54:17 -0500
Received: from zeus.kernel.org ([209.10.41.242]:65225 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129226AbRAINyE>;
	Tue, 9 Jan 2001 08:54:04 -0500
Date: Tue, 9 Jan 2001 13:52:26 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010109135226.B4284@redhat.com>
In-Reply-To: <20010108180857.A26776@athlon.random> <Pine.GSO.4.21.0101081236440.4061-100000@weyl.math.psu.edu> <20010108212833.S27646@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010108212833.S27646@athlon.random>; from andrea@suse.de on Mon, Jan 08, 2001 at 09:28:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 08, 2001 at 09:28:33PM +0100, Andrea Arcangeli wrote:
> On Mon, Jan 08, 2001 at 12:58:20PM -0500, Alexander Viro wrote:
> > It's a hell of a pain wrt locking. You need to lock the parent, but it can
> 
> This is a no-brainer and bad implementation, but shows it's obviously right
> wrt locking. (pseudocode, I ignored the uaccess details and all the other not
> relevant things)
> 
> 		err = sys_getcwd(buf, PAGE_SIZE)
> 		if (!memcmp(path, ".", 2))
> 			path = buf
> 		err = 2_4_0_sys_rmdir(path)

> Could you enlight me on where's the locking pain?

Do the above while another process is renaming one of your parents and
watch an innocent directory get shot down in flames, or prepare for an
incorrect ENOENT.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
