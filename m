Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277667AbRJRKMz>; Thu, 18 Oct 2001 06:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277686AbRJRKMo>; Thu, 18 Oct 2001 06:12:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:54390 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277667AbRJRKMf>; Thu, 18 Oct 2001 06:12:35 -0400
Date: Thu, 18 Oct 2001 12:06:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Chip Salzenberg <chip@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13pre3aa1: expand_fdset() may use invalid pointer
Message-ID: <20011018120614.K12055@athlon.random>
In-Reply-To: <20011017113245.A3849@perlsupport.com> <20011017204204.C2380@athlon.random> <20011018121124.L11266@in.ibm.com> <20011018102226.I12055@athlon.random> <20011018151828.M11266@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011018151828.M11266@in.ibm.com>; from maneesh@in.ibm.com on Thu, Oct 18, 2001 at 03:18:28PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 03:18:28PM +0530, Maneesh Soni wrote:
> We also thought of embedding rcu head in the files_struct, but that was ruled

Ah, that's what I had in mind while writing my last email, I thought the
rcu_head and the parameters to the call_rcu were living in the
files_struct. I should have better checked the code. In short
rcu_fd_array and friend are just artificial structs dynamically
allocated just for the purpose of the rcu freeing of the memory. This
has the advantage of also saving some byte during production, and of
course my suggestion to take rcu_head at the end of the struct was in
turn flawed as well, it's not going to make a real difference since the
rcu_head will be used during call_rcu anyways and the rcu freeing path
has to be a very uncommon path in first place.

> out as we are not freeing the entire files_struct but a couple of fields in
> it. So it may happen that before the callback for one files_struct is processed 
> we queue another one for the same files_struct.

I see, the dynamic allocation of the rcu_fd_array and friend solve the
multiple call_rcu on the same files_struct problem very cleanly.

Ok, so please forget my last email, your last patch looks fine. Thanks!

Andrea
