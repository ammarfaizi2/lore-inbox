Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSGYWJp>; Thu, 25 Jul 2002 18:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSGYWJp>; Thu, 25 Jul 2002 18:09:45 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:39114 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316578AbSGYWJo>;
	Thu, 25 Jul 2002 18:09:44 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 16:05:59 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725160559.X2276@host110.fsmlabs.com>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725150525.Q2276@host110.fsmlabs.com> <20020725220643.GT1180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725220643.GT1180@dualathlon.random>; from andrea@suse.de on Fri, Jul 26, 2002 at 12:06:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch works, though.  I'm seeing lots of function names in ksyms -a
and haven't done a single export_symbol in any module.  Perhaps you mean
only in the kernel.  Do I misunderstand?

} Hmm no, only functions that are explicitly exported through
} EXPORT_SYMBOL are given, they're the only one needed, if you were right
} the modules would be wasting an overkill of kernel not swappable ram for
} no good reason. This is true for both kernel and modules, no difference.
} 
} And even if only the non static ones would not be given still it would
} be an high probability to need the system.map to resolve it.

That it certainly is!

} I appreciated it as a good start to get more reliable module reports,
} but I think it's not the best way to do it (but still it's way better
} than nothing! :).

Explaining to people what a System.map is, how to send it to me and trying
to get them to be methodical enough to be sure they're sending the right
one is a sure road to insanity.  I took a daytrip down that road once.

} I'm not trying to make it easier, I'm trying to make it possible at all.
} 
} Right now if I get an oops into a module from an user I cannot debug it
} period. I'm missing information that I cannot generate on my side. Every
} time he loads the module it will be at a different address (in
} particular with my tree where I try to allocate modules in multipages to
} get faster performance of the binary image at runtime even if they will
} use more ram), so unless he managed running ksymoops on the "after-oops"
} semi broken kernel, the oops will be totally useless.

It's hard in a cross-build environment to get ksymoops to be useful,
though.  If you have suggestions, I have the will.

} Printing the start of each affected module into the oops will solve the
} problem and it will make possible for us to debug oopses that involves
} modules.  Then to automate it we ""only"" need to teach ksymoops to
} parse those module-start informations.
