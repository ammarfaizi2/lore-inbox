Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262613AbSIPQ7q>; Mon, 16 Sep 2002 12:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSIPQ7q>; Mon, 16 Sep 2002 12:59:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15883 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262613AbSIPQ7p>; Mon, 16 Sep 2002 12:59:45 -0400
Date: Mon, 16 Sep 2002 18:04:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: tomc@teamics.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem:  RFC1166 addressing
Message-ID: <20020916180441.E23094@flint.arm.linux.org.uk>
References: <OF298A60D6.2FD15C58-ON86256C36.005B260E@teamics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF298A60D6.2FD15C58-ON86256C36.005B260E@teamics.com>; from tomc@teamics.com on Mon, Sep 16, 2002 at 11:50:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 11:50:36AM -0500, tomc@teamics.com wrote:
> RFC 1166 states that:
> 
>  The class A network number 127 is assigned the "loopback"
>          function, that is, a datagram sent by a higher level protocol
>          to a network 127 address should loop back inside the host.  No
>          datagram "sent" to a network 127 address should ever appear on
>          any network anywhere.

Things to note:

"should" != "must"

1166 Internet numbers. S. Kirkpatrick, M.K. Stahl, M. Recker.
     Jul-01-1990. (Format: TXT=566778 bytes) (Obsoletes RFC1117, RFC1062,
     RFC1020) (Status: INFORMATIONAL)
               ^^^^^^^^^^^^^^^^^^^^^ (not a standard)

RFC2119 defines should and must as:

1. MUST   This word, or the terms "REQUIRED" or "SHALL", mean that the
   definition is an absolute requirement of the specification.

3. SHOULD   This word, or the adjective "RECOMMENDED", mean that there
   may exist valid reasons in particular circumstances to ignore a
   particular item, but the full implications must be understood and
   carefully weighed before choosing a different course.

> Linux does not enforce this.  I have uncovered some users using this
> function to attempt to circumvent the firewall.  I am able to "create"
> 127 network traffic as follows:
> 
> Machine 1:   ifconfig eth0:1 127.1.2.3   [ running kernel 2.2.14 ]
> 
> Machine 2:   ifconfig eth0:1 127.1.2.4  [ running kernel 2.4.19 ]
> 
> Machine 2:  ping 127.1.2.3
> 
> Packets move between the hosts.    Also seems to work on Macintosh.

If your users have access to ifconfig, then they can also send out
whatever packets they want via raw network sockets, even packets that
appear to be coming from external IP addresses.  Adding protection
into the kernel for 127/8 buys you nothing from a determined user
that has root.

I'd suggest configuring the firewall up correctly; deny traffic with
the 127/8 address being received via any non-loopback interface.

A good rule of thumb for firewalls:  Deny everything.  Then
explicitly specify what you want to let through.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

