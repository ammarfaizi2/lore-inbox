Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbSLRAcN>; Tue, 17 Dec 2002 19:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSLRAcN>; Tue, 17 Dec 2002 19:32:13 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:55992
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267005AbSLRAcM>; Tue, 17 Dec 2002 19:32:12 -0500
Message-ID: <3DFFC375.4000103@redhat.com>
Date: Tue, 17 Dec 2002 16:38:13 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171619230.1578-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171619230.1578-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> No, the way sysenter works, the table approach just sucks up dcache space
> (the kernel cannot know which sysenter is the one that the user uses
> anyway, so the jump table would have to just add back some index and we'd
> be back exactly where we started)
> 
> I'll keep it the way it is now.

I won't argue since honestly, not doing it is much easier for me.  But I
want to be sure I'm clear.

What I suggested is to have the first part of the global page be


   .p2align 3
   jmp sysenter_label
   .p2align 3
   jmp sysenter_label
   ...
   .p2align
   jmp userlevel_gettimeofday

sysenter_label:
  the usual sysenter code

userlevel_gettimeofday:
  whatever necessary


All this would be in the global page.  There is only one sysenter call.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

