Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSHJIEY>; Sat, 10 Aug 2002 04:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSHJIEY>; Sat, 10 Aug 2002 04:04:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5134 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316662AbSHJIEX>; Sat, 10 Aug 2002 04:04:23 -0400
Date: Sat, 10 Aug 2002 09:08:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261!
Message-ID: <20020810090803.A7235@flint.arm.linux.org.uk>
References: <3D542D75.7FEA9DDF@zip.com.au> <8412.1028941782@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8412.1028941782@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Aug 10, 2002 at 11:09:42AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 11:09:42AM +1000, Keith Owens wrote:
> On Fri, 09 Aug 2002 14:00:37 -0700, 
> Andrew Morton <akpm@zip.com.au> wrote:
> >It would be much more useful if the oops code were to dump the
> >text preceding the exception EIP rather than after it, actually.
> >I think Keith said that ksymoops supports that.
> 
> Not only does ksymoops support it but some architectures already do
> this.  Mind you, they are not consistent :(
> 
> Alpha:  Code: 44220001  f4200003  46520400 <a77d9c38> 6b9b4a40  a44803a8  42425401  42c10403  40603401
> Arm:    Code: e7973108 e1a02423 (e5c42001) e5c43000 e1a02823
> 
> If any instruction in the code line is enclosed in <> or () then
> ksymoops assumes that the first byte is EIP.

In 2.5, I changed ARM to indicate the last word as the EIP (so we get more
context as Andrew Morton suggests.)  However, ksymoops now seems to ignore
the '()' !

At some point I plan to check what happens if its the second to last.  I
suspect ksymoops is looking for the strings ' (' and ') ', the second of
which obviously doesn't exist.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

