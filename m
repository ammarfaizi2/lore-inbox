Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318641AbSGZXf2>; Fri, 26 Jul 2002 19:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318647AbSGZXf2>; Fri, 26 Jul 2002 19:35:28 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:50323 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318641AbSGZXf1>;
	Fri, 26 Jul 2002 19:35:27 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 26 Jul 2002 17:31:27 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names on oops()]
Message-ID: <20020726173127.S13656@host110.fsmlabs.com>
References: <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random> <20020725160559.X2276@host110.fsmlabs.com> <20020725225613.GW1180@dualathlon.random> <20020725170113.F5326@host110.fsmlabs.com> <20020726223750.GA1151@dualathlon.random> <20020726165535.R13656@host110.fsmlabs.com> <20020726232834.GA1168@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020726232834.GA1168@dualathlon.random>; from andrea@suse.de on Sat, Jul 27, 2002 at 01:28:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found those cases, nope.  Even with them, it is nice to resolve
to the nearest symbol when we can.  Printing the beginning and end of the
module that you put in there is useful, though.

Any names for the stack trace are a mess, since formatting that is hard
without scrolling off the screen and making the oops useless.  My patch was
just a first cut to get a symbol name and module name for the EIP.  I think
that's a good start and it seems your version actually removes some of the
very simple functionality that I wanted to be able to use.

Do I follow what you're doing correctly or do I have it confused?

} that's why, because of those cases. I thought you had those cases too
} right? And for ksymoops it's much simpler to avoid the reverse lookup.
} 
} I think either you go kksymoops, or you go my way + module tracking
} aware ksymoops (only one "k"), the intermediate approch is probably a
} nice way but handy only until a module tracking aware ksymoops exists.
} 
} Furhtmore your patch doesn't really provide all the info need, you
} only take care of the module where the EIP lives, you don't handle the
} case of multiple module addresses in the stack trace. And printing lots
} of symbols for the stack trace too (potentially to reverse all the time
} too) can overflow the screen.  Infact I also considered to print modules
} tracking info without \n in between even if it can overflow to save
} screen ram space. Maybe that's worhwhile, OTOH I wouldn't expect more
} than a few lines usually and the \n makes it more readable but I may
} change it to use better the screen space.
