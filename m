Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbTCGLlM>; Fri, 7 Mar 2003 06:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbTCGLlM>; Fri, 7 Mar 2003 06:41:12 -0500
Received: from packet.digeo.com ([12.110.80.53]:16777 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261538AbTCGLlK>;
	Fri, 7 Mar 2003 06:41:10 -0500
Date: Fri, 7 Mar 2003 03:51:45 -0800
From: Andrew Morton <akpm@digeo.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] memleak in load_elf_binary?
Message-Id: <20030307035145.0f632131.akpm@digeo.com>
In-Reply-To: <20030307143607.E7347@namesys.com>
References: <20030307141247.D7347@namesys.com>
	<20030307032532.17d37207.akpm@digeo.com>
	<20030307143607.E7347@namesys.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 11:51:38.0878 (UTC) FILETIME=[E988B9E0:01C2E49F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@namesys.com> wrote:
>
> Hello!
> 
> On Fri, Mar 07, 2003 at 03:25:32AM -0800, Andrew Morton wrote:
> > >    I am still playing with improving memleak detector thing from smatch project.
> > >    Seems there is a memleak in fs/binfmt_elf.c::load_elf_binary() in current 2.5
> > >    If setup_arg_pages() fails (line 638 in my sources) we do return but 
> > >    not freeing possibly allocated elf_interpreter (line 520) and 
> > >    allocated elf_phdata (line 500) areas.
> > >    Is this looking real? At least it looks real for me (I am trying to get
> > >    number of false positives way down).
> > Yes, you're right.  And there's a second one further down.
> 
> Ah, hm? Can you be mo precise? I do not see it.
> 
> Next return I see is in line 745, and the memory is freed before it.
> 

It forgets to close the file.  It'll be closed anyway by exit so
I guess that's OK.
