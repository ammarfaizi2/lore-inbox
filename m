Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135843AbRDTJ6C>; Fri, 20 Apr 2001 05:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135844AbRDTJ5w>; Fri, 20 Apr 2001 05:57:52 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51656 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135843AbRDTJ5o>;
	Fri, 20 Apr 2001 05:57:44 -0400
Message-ID: <3AE00814.10A87766@mandrakesoft.com>
Date: Fri, 20 Apr 2001 05:57:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: Roberto Nibali <ratz@tac.ch>, linux-kernel@vger.kernel.org,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104200244000.5165-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> On Fri, 20 Apr 2001, Jeff Garzik wrote:
> > > Check again. drivers/net builds a .a, not a .o. Trust me, I've tried.

> > Sure, but if you are patching anyway, it much better to fix that than
> > hack space.c :)
> 
> Well, I remember asking Alan if he'd prefer it done that way, and not
> getting a reply back. So I didn't press further.
> 
> The change to support __init/__exit in drivers/net is a no-brainer, and I
> did test it at the time -- it worked as expected. But it's really up to
> Alan to decide, I couldn't care less to be quite honest.
> 
> In a way I think I understand why he's reluctant: it's very easy to end up
> changing the initialization order by mistake and messing up people's
> network setups.

Sorry, I was talking about a local patch not a global patch.  If a user
must patch their 2.2 kernel to get the starfire driver working anyway,
then adding a change to do s/.a/.o/ on Makefiles would be simple.

That said, a 2.2.20 patch to s/.a/.o/ should not break anything at all. 
All old drivers work as before through the static call chain.  All newer
drivers using module_init/exit simply wind up being initialized after
all static initialization has occurred.  With some subsystems this does
create a chicken-and-egg situation, but not for drivers/net...

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
