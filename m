Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbSKGP1E>; Thu, 7 Nov 2002 10:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbSKGP1E>; Thu, 7 Nov 2002 10:27:04 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:221 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261271AbSKGP1D>;
	Thu, 7 Nov 2002 10:27:03 -0500
Date: Thu, 7 Nov 2002 16:33:42 +0100
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: IPSEC FIRST LIGHT! (by non-kernel developer :-))
Message-ID: <20021107153342.GA30515@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	kuznet@ms2.inr.ac.ru
References: <20021107130244.GA25032@outpost.ds9a.nl> <20021107.052114.123991710.davem@redhat.com> <20021107141219.GA28791@outpost.ds9a.nl> <20021107.071808.43409100.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107.071808.43409100.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 07:18:08AM -0800, David S. Miller wrote:

>    Does it require more than setkey? Or does it need pseudo devices, GRE or
>    anything? Just setting up tunnel mode doesn't appear to work - nothing gets
>    crypted or signed.
> 
> Alexey, any ideas?

This is the setup I am using ON host 10.0.0.216 itself:

# AH
add 1.2.3.4 10.0.0.216 ah 25700 -A hmac-md5 "1234567890123456";
add 10.0.0.216 1.2.3.4 ah 34500 -A hmac-md5 "1234567890123456";

# ESP
add 1.2.3.4 10.0.0.216 esp 25701 -E 3des-cbc "123456789012123456789012";
add 10.0.0.216 1.2.3.4 esp 34501 -E 3des-cbc "123456789012123456789012";

spdadd 10.0.0.0/24 1.2.3.0/24 any -P out ipsec
           esp/tunnel/1.2.3.4-10.0.0.216/require;

If I now ping 1.2.3.4, I see the packet go out on the wire unencrypted.

If I ping from 10.0.0.11 with a route to 1.2.3.0/24 to the ipsec host
10.0.0.216, I get an ICMP redirect.

Oh, by the way, my lowly pentiumpro200 manages to crypt *6 megabits/second*
with 3des-cbc! The box does get a bit slowish over the network then though.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
