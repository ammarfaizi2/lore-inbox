Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288224AbSACGke>; Thu, 3 Jan 2002 01:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288225AbSACGkY>; Thu, 3 Jan 2002 01:40:24 -0500
Received: from monster.nni.com ([216.107.0.51]:62481 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S288224AbSACGkP>;
	Thu, 3 Jan 2002 01:40:15 -0500
From: "Andrew Rodland" <arodland@noln.com>
Subject: Re: CML2 funkiness
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, relson@osagesoftware.com
X-Mailer: CommuniGate Pro Web Mailer v.3.5
Date: Thu, 03 Jan 2002 01:40:15 -0500
Message-ID: <web-54809847@admin.nni.com>
In-Reply-To: <20020102100311.A7819@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found it!
The culprit: a bit of confusion over 'private'.
All of the not-saved symbols were just guards for 'do we
 want to display question X'... so they were marked
 private, so as not to clutter up the kernel (I assume).
 However, this prevents them from getting written to
 .config/config.out as well! Easy fix is to un-private
 them, long-term is (as I see it) either to create a new
 equivalent to private that somehow lets the symbol get
 written to defconfig, but prevents it from becoming a
 kernel define, or just to blow it off and don't worry
 about it, and leave them normal symbols. However, it's
 1:30AM and I might be missing something.

--Andrew

On Wed, 2 Jan 2002 10:03:11 -0500
 "Eric S. Raymond" <esr@thyrsus.com> wrote:
> David Relson <relson@osagesoftware.com>:
> >  From past testing of CML2 I know it uses file
>  config.out as its 
> > "memory".  Looking in it, I didn't see any CONFIG
>  symbols for these symbols.
> > 
> > There's definitely something here for Eric to fix!
> 
> I'm on it.
> -- 
> 		<a href="http://www.tuxedo.org/~esr/">Eric S.
>  Raymond</a>
> 
> Live free or die; death is not the worst of evils.
> 	-- General George Stark.

