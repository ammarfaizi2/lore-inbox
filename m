Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271467AbRIFRFg>; Thu, 6 Sep 2001 13:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271473AbRIFRF0>; Thu, 6 Sep 2001 13:05:26 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:43697 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271467AbRIFRFM>;
	Thu, 6 Sep 2001 13:05:12 -0400
Date: Thu, 06 Sep 2001 18:05:30 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>
Cc: Wietse Venema <wietse@porcupine.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip
 alias bug 2.4.9 and 2.2.19]
Message-ID: <605440607.999799530@[10.132.112.53]>
In-Reply-To: <20010906203854.A23109@castle.nmd.msu.ru>
In-Reply-To: <20010906203854.A23109@castle.nmd.msu.ru>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey,

--On Thursday, September 06, 2001 8:38 PM +0400 Andrey Savochkin 
<saw@saw.sw.com.sg> wrote:

> Hell, how else could you define the notion of a local address as not the
> address which responds to pings without external network, the address for
> which

So the remote end of a looped /30 serial line is now a local address?
Can you bind() to 127.0.0.2? In any case, all you've found is a
peculiarity of the loopback driver. So send a patch.

The read RFC1122. (hosts & routers requirements).
Not only does this define local address, but specifically writes:

         3.3.4.2  Multihoming Requirements

            The following general rules apply to the selection of an IP
            source address for sending a datagram from a multihomed
            host.

            (1)  If the datagram is sent in response to a received
                 datagram, the source address for the response SHOULD be
                 the specific-destination address of the request.  See
                 Sections 4.1.3.5 and 4.2.3.7 and the "General Issues"
                 section of [INTRO:1] for more specific requirements on
                 higher layers.

                 Otherwise, a source address must be selected.

            (2)  An application MUST be able to explicitly specify the
                 source address for initiating a connection or a
                 request.

How can (2) be usefully true if the application cannot determine
what the list of valid local addresses are? Or is your argument
that all such addresses should be configured manually, rather
than by the application? Which would not only be a rather
odd point of view, but makes implementing things like
BGP, which depends on being able to get the outbound interface
address used for a session up to the higher layers, rather hard.

--
Alex Bligh
