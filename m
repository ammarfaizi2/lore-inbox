Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315166AbSENDbv>; Mon, 13 May 2002 23:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSENDbu>; Mon, 13 May 2002 23:31:50 -0400
Received: from zok.SGI.COM ([204.94.215.101]:20410 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315166AbSENDbt>;
	Mon, 13 May 2002 23:31:49 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.1[345]-dj Add cpqarray_init() back into genhd.c 
In-Reply-To: Your message of "Mon, 13 May 2002 22:49:08 -0400."
             <20020514024908.GA7695@www.kroptech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 May 2002 13:31:38 +1000
Message-ID: <6976.1021347098@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002 22:49:08 -0400, 
Adam Kropelin <akropel1@rochester.rr.com> wrote:
>On Tue, May 14, 2002 at 12:24:23PM +1000, Keith Owens wrote:
>> The real problem appears to be cpqarray.c, it wraps the init/exit code
>> in #ifdef MODULE, so the init code is only available to modules.  I
>> think that cpqarray.c should remove the #ifdef MODULE and use the same
>> init mechanism as other drivers, including module_init/exit.  I don't
>> have a card and the code is a mess so I am not going to attempt a patch.
>
>I'm not seeing it. I see init_module() and cleanup_module() wrapped as you say
>but cpqarray_init() is outside the #ifdef. Also, two versions of cpqarray_setup
>are provided based on #ifdef MODULE but this doesn't look problematic to me.
>I'm a newbie, for sure. Am I overlooking something obvious?

The call to cpqarray_init() is from init_module() which does not exist
when the code is built in.  See drivers/block/loop.c for an example of
the correct use of init and exit routines, using module_init and
module_exit.

