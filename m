Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSKHLIt>; Fri, 8 Nov 2002 06:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSKHLIt>; Fri, 8 Nov 2002 06:08:49 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:45754 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261849AbSKHLIs>;
	Fri, 8 Nov 2002 06:08:48 -0500
Date: Fri, 8 Nov 2002 12:15:29 +0100
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: mdiehl@dominion.dyndns.org, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: [documentation] Re: [LARTC] IPSEC FIRST LIGHT! (by non-kernel developer :-))
Message-ID: <20021108111529.GA19850@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, mdiehl@dominion.dyndns.org,
	linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
References: <20021107130244.GA25032@outpost.ds9a.nl> <20021108023926.51B985606@dominion.dyndns.org> <20021108094122.GB16512@outpost.ds9a.nl> <20021108.015230.94737520.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108.015230.94737520.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 01:52:30AM -0800, David S. Miller wrote:
>    From: bert hubert <ahu@ds9a.nl>
>    Date: Fri, 8 Nov 2002 10:41:22 +0100
>    
>    Perhaps dave can re-diff?
> 
> This is against current BK-2.5

Dave,

This code locks up solid on any ipsec TCP traffic outgoing with this
configuration:

add 10.0.0.11 10.0.0.216 ah 15700 -A hmac-md5 "1234567890123456";
add 10.0.0.216 10.0.0.11 ah 24500 -A hmac-md5 "1234567890123456";

# ESP
add 10.0.0.11 10.0.0.216 esp 15701 -E 3des-cbc "123456789012123456789012";
add 10.0.0.216 10.0.0.11 esp 24501 -E 3des-cbc "123456789012123456789012";

spdadd 10.0.0.216 10.0.0.11 any -P out ipsec
           esp/transport//require
           ah/transport//require;

spdadd 10.0.0.11 10.0.0.216 any -P in ipsec
           esp/transport//require
           ah/transport//require;

ICMP traffic is fine however. I'm now investigating how far it gets before
locking up. 

Regards,

bert


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
