Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTGKPV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTGKPV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:21:26 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:50624 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263319AbTGKPVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:21:24 -0400
Date: Fri, 11 Jul 2003 08:35:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jon Masters <jonathan@jonmasters.org>
Cc: linux-kernel@vger.kernel.org, jcm@printk.net
Subject: Re: Stripped binary insertion with the GNU Linker suggestions (fwd)
Message-ID: <20030711153557.GB30378@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jon Masters <jonathan@jonmasters.org>, linux-kernel@vger.kernel.org,
	jcm@printk.net
References: <Pine.LNX.4.10.10307111619290.25244-100000@router>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10307111619290.25244-100000@router>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 04:19:55PM +0100, Jon Masters wrote:
> I have seen other nasty ways to do this involving converting the image to
> byte values in very large arrays or inserting literal byte values in to
> the output file but there just has to be a generic method for inserting
> an image in to the middle of an output file.

No, there isn't, at least I haven't found one.  The BK installer does 
exactly what you want (and you can have the source if you like, BSD 
license) on the platforms listed below.  We had to play some nasty 
games to make this work, I believe it was HP-UX which "knew" that your
array was full of zeros and did not allocate it, it did it at runtime.
Any sort of predictable pattern it figured out, the following fools it
for now:

unsigned char data_data[3866327] = {
        255,
        6,
        1,
        2,
        3,
        4,
        255,
        3,
        9,
        62,
        255,
        10,
        4,
        61,
        255,
};

platforms that this technique works on:

    alpha-glibc22-linux
    alpha-osf5.1
    arm-glibc21-linux
    hppa-glibc22-linux
    hppa-hpux
    ia64-glibc22-linux
    mips-glibc22-linux
    mips-irix
    mipsel-glibc20-linux
    powerpc-aix
    powerpc-darwin6.6
    powerpc-glibc21-linux
    sparc-glibc21-linux
    sparc-solaris
    x86-freebsd2.2.8
    x86-freebsd3.2
    x86-freebsd4.1
    x86-glibc20-linux
    x86-glibc21-linux
    x86-glibc22-linux
    x86-netbsd
    x86-openbsd
    x86-sco3.2v5.0.7
    x86-solaris

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
