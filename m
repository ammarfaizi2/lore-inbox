Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269042AbRHFWFr>; Mon, 6 Aug 2001 18:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269047AbRHFWFi>; Mon, 6 Aug 2001 18:05:38 -0400
Received: from fe6.rdc-kc.rr.com ([24.94.163.53]:39430 "EHLO mail6.kc.rr.com")
	by vger.kernel.org with ESMTP id <S269042AbRHFWF1>;
	Mon, 6 Aug 2001 18:05:27 -0400
To: miquels@cistron-office.nl (Miquel van Smoorenburg)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why can't I ptrace init (pid == 1) ?
In-Reply-To: <102490000.992966603@changeling.engr.sgi.com>
	<3B3060C0.B2D368C@idb.hist.no> <9gpnqu$8lv$2@ncc1701.cistron.net>
From: Mike Coleman <mkc@mathdogs.com>
Date: 06 Aug 2001 17:05:25 -0500
In-Reply-To: <9gpnqu$8lv$2@ncc1701.cistron.net>
Message-ID: <873d74c09m.fsf@mathdogs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miquels@cistron-office.nl (Miquel van Smoorenburg) writes:
> The reason right now is I think that ptrace mucks around with sibling
> relations and since init is a special 'father of all processes' (or is that
> mother?) that would get the system into trouble real soon.

Yes.  Ptrace does a sort of fakey reparenting of traced processes, which won't
work correctly with init, since it's its own parent.

Notice that init *is* currently allowed to do a PTRACE_TRACEME, which would
almost certainly cause the system to fail spectacularly.  It's not really a
security problem, since init can do anything anyway, but it does annoy my
aesthetic sensibilities a bit.  (The patch I sent to fix this wasn't
incorporated.)

-- 
Mike Coleman, mkc@mathdogs.com
http://www.mathdogs.com
problem solving, expert software development
