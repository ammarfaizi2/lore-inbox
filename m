Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292116AbSBOLlF>; Fri, 15 Feb 2002 06:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292117AbSBOLkx>; Fri, 15 Feb 2002 06:40:53 -0500
Received: from unthought.net ([212.97.129.24]:36571 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S292116AbSBOLkh>;
	Fri, 15 Feb 2002 06:40:37 -0500
Date: Fri, 15 Feb 2002 12:40:36 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Michael Sinz <msinz@wgate.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control
Message-ID: <20020215124036.C23673@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Michael Sinz <msinz@wgate.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6BE18F.7B849129@wgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3C6BE18F.7B849129@wgate.com>; from msinz@wgate.com on Thu, Feb 14, 2002 at 11:10:55AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 11:10:55AM -0500, Michael Sinz wrote:
> I have, for a long time, wished that Linux had a way to specify where
> core dumps are stored and what the name of the core dump is.  Now that
> I have been building large linux clusters with many diskless nodes,
> this need has become even more important.
...

I just wanted to throw in my 0.02 Euro on this one:

I have not yet tested your patch yet - but this functionality is *very*
important to my company as well.

Anyone developing applications with multiple processes will benefit
significantly from having core files named differnetly than just "core".

A patch was included in the kernel some time ago, to allow the appending of the
PID - however, this is not really good enough. It's better than nothing, but
it's not good.

What I want is "core.[process name]" eventually with a ".[pid]" appended.  A
flexible scheme like your patch implements is very nice.   Actually having
the core files in CWD is fine for me - I mainly care about the file name.

Furthermore, the patch that went in earlier is *horrible* code. Let me give a
few examples:

...
        char corename[6+sizeof(current->comm)+10];
...
        memcpy(corename,"core.", 5);
        corename[4] = '\0';
...
        if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
                sprintf(&corename[4], ".%d", current->pid);


Enough said.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
