Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSEDJqP>; Sat, 4 May 2002 05:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSEDJqO>; Sat, 4 May 2002 05:46:14 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:32004 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S293457AbSEDJqN>; Sat, 4 May 2002 05:46:13 -0400
Date: Sat, 4 May 2002 11:46:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: bruce.holzrichter@monster.com, linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: my slab cache broken on sparc64
In-Reply-To: <20020503.200747.104775821.davem@redhat.com>
Message-ID: <Pine.LNX.4.21.0205041144020.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, 3 May 2002, David S. Miller wrote:

> If the __get_user() fails, you will leave the kernel in the
> KERNEL_DS segment.
> 
> Do it like this instead.
> 
> 	int fault;
> 	mm_segment_t old_fs;
> 
> 	...
> 
> 	old_fs = get_fs();
> 	set_fs(KERNEL_DS);
> 	fault = __get_user(tmp, pc->name);
> 	set_fs(old_fs);
> 
> 	if (fault) {
> 	...

He can also simply move it outside of the loop to avoid this problem.

bye, Roman

