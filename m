Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135910AbREAVcz>; Tue, 1 May 2001 17:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136728AbREAVcf>; Tue, 1 May 2001 17:32:35 -0400
Received: from www.linux.org.uk ([195.92.249.252]:12050 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S135910AbREAVc2>;
	Tue, 1 May 2001 17:32:28 -0400
Date: Tue, 1 May 2001 22:31:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
Message-ID: <20010501223154.G3541@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010501204543.B3541@flint.arm.linux.org.uk> <Pine.LNX.4.31.0105011417320.2667-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0105011417320.2667-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 01, 2001 at 02:19:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 02:19:33PM -0700, Linus Torvalds wrote:
> On Tue, 1 May 2001, Russell King wrote:
> > Talking around this issue, is there any chance of getting the
> > official use of the first parameter to ioremap documented in
> > Documentation/IO-mapping.txt please?  There appears to be
> > confusion as to whether it is:
> >
> > a) PCI bus address
> > b) CPU untranslated address
> 
> It's neither.
> 
> It's a cookie that you can do arithmetic off and pass on to the
> readx/writex, and nothing more. You cannot make any assumptions at all
> about what it means.
> 
> In particular, you can _not_ assume that it is a PCI bus address ("WHICH
> bus?") and you can absolutely not assume that it is a CPU address (many
> CPU's do not "memory map" PCI at all).

In which case, can we change the following in IO-mapping.txt please?

        /*
         * remap framebuffer PCI memory area at 0xFC000000,
         * size 1MB, so that we can access it: We can directly
         * access only the 640k-1MB area, so anything else
         * has to be remapped.
         */
        char * baseptr = ioremap(0xFC000000, 1024*1024);

since its not true?  (since 0xfc000000 is a cookie).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

