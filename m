Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbTCGLPA>; Fri, 7 Mar 2003 06:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261517AbTCGLPA>; Fri, 7 Mar 2003 06:15:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:59272 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261513AbTCGLO6>;
	Fri, 7 Mar 2003 06:14:58 -0500
Date: Fri, 7 Mar 2003 03:25:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] memleak in load_elf_binary?
Message-Id: <20030307032532.17d37207.akpm@digeo.com>
In-Reply-To: <20030307141247.D7347@namesys.com>
References: <20030307141247.D7347@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 11:25:26.0576 (UTC) FILETIME=[405E7B00:01C2E49C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> Hello!
> 
>    I am still playing with improving memleak detector thing from smatch project.
> 
>    Seems there is a memleak in fs/binfmt_elf.c::load_elf_binary() in current 2.5
>    If setup_arg_pages() fails (line 638 in my sources) we do return but 
>    not freeing possibly allocated elf_interpreter (line 520) and 
>    allocated elf_phdata (line 500) areas.
> 
>    Is this looking real? At least it looks real for me (I am trying to get
>    number of false positives way down).
> 

Yes, you're right.  And there's a second one further down.

Whoever thought of permitting more than one `return' statement in a C
function should be shot.

This needs a little thought, as we've already set the new personality and the
old executable has been rubbed out.
