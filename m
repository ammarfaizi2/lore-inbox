Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSJUQpt>; Mon, 21 Oct 2002 12:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSJUQpt>; Mon, 21 Oct 2002 12:45:49 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:4606 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261477AbSJUQov>; Mon, 21 Oct 2002 12:44:51 -0400
Date: Mon, 21 Oct 2002 12:50:56 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Gardiner Myers <jgmyers@netscape.com>,
       "Charles 'Buck' Krasic" <krasic@acm.org>,
       Davide Libenzi <davidel@xmailserver.org>, Dan Kegel <dank@kegel.com>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
Message-ID: <20021021125056.B27389@redhat.com>
References: <Pine.LNX.4.44.0210151601560.1554-100000@blue1.dev.mcafeelabs.com> <3DACA5E4.7090509@netscape.com> <xu4lm4zf6ew.fsf@brittany.cse.ogi.edu> <3DADB020.4060506@netscape.com> <1035219498.27318.205.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035219498.27318.205.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 21, 2002 at 05:58:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 05:58:17PM +0100, Alan Cox wrote:
> I think a chunk of the poll scaling problem is better addressed by
> futexes. If I can say "this futex list for this fd for events X Y and Z"
> I can construct almost all the efficient stuff I need out of the futex
> interfaces, much like doing it with SIGIO setting flags but a lot less
> clocks

I've structured the aio userland structure so that this is possible, just 
not implemented yet.  There are fields for compatible and incompatible 
features, as well as the length of the header.  This way, the library can 
implement a faster getevents call when futex support is added, but it 
always has the option of falling back to the syscall should it not understand 
any changes we make to the data structure.

		-ben
-- 
"Do you seek knowledge in time travel?"
