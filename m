Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262699AbTC0ANi>; Wed, 26 Mar 2003 19:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262711AbTC0ANh>; Wed, 26 Mar 2003 19:13:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41230 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262699AbTC0ANf>; Wed, 26 Mar 2003 19:13:35 -0500
Date: Thu, 27 Mar 2003 00:24:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: henrique.gobbi@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interpretation of termios flags on a serial driver
Message-ID: <20030327002444.M8871@flint.arm.linux.org.uk>
Mail-Followup-To: henrique.gobbi@cyclades.com, linux-kernel@vger.kernel.org
References: <1046909941.1028.1.camel@gandalf.ro0tsiege.org> <20030326092010.3EDA8124023@mx12.arcor-online.net> <3E81BE5C.400@cyclades.com> <Pine.LNX.4.53.0303261804020.2833@chaos> <3E81C846.6010901@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E81C846.6010901@cyclades.com>; from henrique2.gobbi@cyclades.com on Wed, Mar 26, 2003 at 03:33:26PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 03:33:26PM +0000, Henrique Gobbi wrote:
> Thanks for the feedback.
> 
> > If PARENB is set you generate parity. It is ODD parity if PARODD
> > is set, otherwise it's EVEN. There is no provision to generate
> > "stick parity" even though most UARTS will do that. When you
> > generate parity, you can also ignore parity on received data if
> > you want.  This is the IGNPAR flag.
> 
> Ok. But, considering the 2 states of the flag IGNPAR, what should the 
> driver do with the chars that are receiveid with wrong parity, send this 
> data to the TTY with the flag TTY_PARITY or just discard this data ?

We follow POSIX, which says that if IGNPAR is set, bytes with framing
or parity errors (but not break's) are ignored.  If IGNPAR is clear
and INPCK is set, check parity, and flag it via the TTY_PARITY flag.
If INPCK is clear, don't check parity at all.

Note that PARENB enables/disables the generation and reception of
parity.  INPCK controls whether you detect received character parity
errors, and IGNPAR tells you what to do when a character with incorrect
parity is received.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

