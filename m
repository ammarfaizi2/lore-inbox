Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270857AbRIFOR7>; Thu, 6 Sep 2001 10:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270958AbRIFORu>; Thu, 6 Sep 2001 10:17:50 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:46340 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S270857AbRIFORb>; Thu, 6 Sep 2001 10:17:31 -0400
Date: Thu, 6 Sep 2001 16:17:49 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Andi Kleen <ak@suse.de>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, Wietse Venema <wietse@porcupine.org>
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010906161749.C29583@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Andrey Savochkin <saw@saw.sw.com.sg>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	Wietse Venema <wietse@porcupine.org>
In-Reply-To: <20010905170037.A6473@emma1.emma.line.org.suse.lists.linux.kernel> <20010905152738.C5912BC06D@spike.porcupine.org.suse.lists.linux.kernel> <20010905182033.D3926@emma1.emma.line.org.suse.lists.linux.kernel> <oupg0a1wi9x.fsf@pigdrop.muc.suse.de> <20010906173534.A21874@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906173534.A21874@castle.nmd.msu.ru>; from saw@saw.sw.com.sg on Thu, Sep 06, 2001 at 17:35:34 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001, Andrey Savochkin wrote:

> Andi, it's right to the point.

It's false.

> The only one good reason for an SMTP server to bother about IP addresses at
> all is a quick check for mail loops, i.e. a check at the moment of opening
> TCP connection to send a message whether your peer is yourself.
> Bothering about network masks just doesn't have any valid grounds.
> It's not possible to answer the right question (whether you talk to yourself)
> inspecting IP addresses.
> In the original example, mail systems on 192.168.0.4 and 192.168.1.1 may be
> different.

I'm not sure where and why you deduce the idea this is about MTA loop
detection or peer recognition.

Any application that uses SIOCGIFNETMASK would do, it just happened that
Postfix's inet_addr_local was the tool I used when I found out the
sysctl had returned the first netmask for the second address on Linux,
but not on FreeBSD.

> So, the very right way of doing things is:
>  - make admin specify the listening addresses for a mail system in the
>    configuration and use them to check for loops;

Or just use IPADDR_ANY...

>  - never try to learn anything about networking configuration.

...which is wrong, because the MTA must know its own IP addresses to
accept domain literals, and SIOCGIFCONF works and returns all addresses,
it just happens that looking up the second and subsequent masks fails.
Please see RFC-1123, section 5.2.17, for details.

-- 
Matthias Andree
