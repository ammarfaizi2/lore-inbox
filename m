Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131676AbRCXOOs>; Sat, 24 Mar 2001 09:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131679AbRCXOOj>; Sat, 24 Mar 2001 09:14:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6905 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131676AbRCXOO2>;
	Sat, 24 Mar 2001 09:14:28 -0500
Date: Sat, 24 Mar 2001 09:13:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jorgen Cederlof <jorgen.cederlof@cendio.se>
cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bug in do_mount()
In-Reply-To: <20010324145822.B1353@ondska>
Message-ID: <Pine.GSO.4.21.0103240904140.11914-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Mar 2001, Jorgen Cederlof wrote:

>  	if (list_empty(&sb->s_mounts))
>  		kill_super(sb, 0);
> +	else
> +		put_filesystem(fstype);
>  	goto unlock_out;

That's completely wrong. Reference acquired by get_fs_type() is
released by put_filesystem() (near fs_out), _NOT_ by kill_super().
kill_super() releases the reference stored in ->s_type (created
by get_sb_...()). If superblock stays alive you should not release it.

What bug are you trying to fix?
							Al

