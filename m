Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSKGSeq>; Thu, 7 Nov 2002 13:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSKGSeq>; Thu, 7 Nov 2002 13:34:46 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:34269 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261371AbSKGSep>;
	Thu, 7 Nov 2002 13:34:45 -0500
Date: Thu, 7 Nov 2002 19:41:25 +0100
From: bert hubert <ahu@ds9a.nl>
To: kuznet@ms2.inr.ac.ru
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: IPSEC FIRST LIGHT! (by non-kernel developer :-))
Message-ID: <20021107184125.GA840@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, kuznet@ms2.inr.ac.ru,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021107.071808.43409100.davem@redhat.com> <200211071749.UAA10171@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211071749.UAA10171@sex.inr.ac.ru>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 08:49:37PM +0300, kuznet@ms2.inr.ac.ru wrote:

> Also, forwarding is still sick, as I told you before going to sleep,
> so expect a patch soon. Unfortunately, despite of all the precautions
> I sleeped all the day, so I am again at the point when cannot test
> anything but loopback. :-)

Well, you are probably a lot smarter now that you slept all day :-) 

Any way, this patch helps somethat but it is indeed sick:

first time:
connect(3, {sin_family=AF_INET, sin_port=htons(23),
sin_addr=inet_addr("1.2.3.5")}}, 16) = -1 EAGAIN (Resource temporarily
unavailable)

subsequent times:
connect(3, {sin_family=AF_INET, sin_port=htons(23),
sin_addr=inet_addr("1.2.3.5")}}, 16) = -1 ENOMEM (Cannot allocate memory)

With this configuration:

add 1.2.3.4 10.0.0.216 esp 25701 -E 3des-cbc "123456789012123456789012";
add 10.0.0.216 1.2.3.4 esp 34501 -E 3des-cbc "123456789012123456789012";

spdadd 10.0.0.0/24 1.2.3.0/24 any -P out ipsec
           esp/tunnel/10.0.0.216-1.2.3.4/require;

Anything I can do to help, let me know.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
