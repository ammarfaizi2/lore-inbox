Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135341AbRAJStN>; Wed, 10 Jan 2001 13:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135378AbRAJStD>; Wed, 10 Jan 2001 13:49:03 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:35086 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S135341AbRAJSsw>; Wed, 10 Jan 2001 13:48:52 -0500
Date: Wed, 10 Jan 2001 13:48:43 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE
 Linux)
Message-ID: <243350000.979152523@tiny>
In-Reply-To: <Pine.GSO.4.21.0101101229050.13614-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 10, 2001 12:38:34 PM -0500 Alexander Viro
<viro@math.psu.edu> wrote:

> On Wed, 10 Jan 2001, Chris Mason wrote:
> 
>> In filldir, I don't like the line where we ((char *)dirent += reclen ;
>> If reclen is much larger than the buffer sent from userspace, I don't
>> see how we stay in bounds.
> 
>	 So? copy_to_user() and put_user() will refuse to scramble the
> kernel memory. IOW, dirent can be out of the userspace. Hell, user could
> call getdents() and pass it a kernel pointer. Try it and you'll see what
> happens.
> 

Ah thanks, that makes more sense.  But, copy_to_user is only working on
namelen bytes, and reclen is bigger than that.  So, who is checking the
value for the buf->current_dir pointer?

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
