Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270316AbTGMRY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 13:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270317AbTGMRY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 13:24:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13069 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270316AbTGMRY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 13:24:57 -0400
Date: Sun, 13 Jul 2003 18:39:37 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <willy@debian.org>, Bernardo Innocenti <bernie@develer.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: do_div vs sector_t
Message-ID: <20030713183937.F2621@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk> <20030713172622.GA13824@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030713172622.GA13824@twiddle.net>; from rth@twiddle.net on Sun, Jul 13, 2003 at 10:26:23AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 10:26:23AM -0700, Richard Henderson wrote:
> On Fri, Jul 11, 2003 at 11:33:59PM +0100, Matthew Wilcox wrote:
> > Better ideas?
> 
>           if (likely(((n) >> 31 >> 1) == 0)) {
> 

Beware - luckily I don't have to worry about that on ARM (we do our own
thing.)  However, with this code:

int foo(unsigned long long n)
{
        if (((n) >> 31 >> 1) == 0) {
                return 1;
        } else {
                return 0;
        }
}

gcc 3.2.2 on ARM (32-bit) produces some not-very-nice code, consisting of
6 shifts and including placing one register on the stack and completely
ignoring a register which it could freely use instead.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

