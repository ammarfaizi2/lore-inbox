Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277418AbRJJWmk>; Wed, 10 Oct 2001 18:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277501AbRJJWmb>; Wed, 10 Oct 2001 18:42:31 -0400
Received: from nicol6.umkc.edu ([134.193.4.67]:33796 "EHLO nicol6.umkc.edu")
	by vger.kernel.org with ESMTP id <S277418AbRJJWmY>;
	Wed, 10 Oct 2001 18:42:24 -0400
Message-ID: <3BC4CEE8.24BDF078@umkc.edu>
Date: Wed, 10 Oct 2001 17:42:48 -0500
From: David Nicol <nicold@umkc.edu>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en-GB, en, ru
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: per-service window size caches
In-Reply-To: <200110091325.OAA28685@sunuk.UK.Sun.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeremy Harris [RU-UK]" wrote:
> 
>  I'm not sure how to make it work for ftp.


It wouldn't.  Advise to use http:// for downloads.

Alternately, provide some sysctrls for accessing the
windo info cache and let ftp write there

Alternately, make the proxy situation the special case
and in general assume that all ports on a host are handled
in the same way -- possibly fall back to a per-service cache
only after problems have appeared after applying cached window
sizes.  So the cache would look something like:

peer-IP: (window size) or (use *per-service cache) or (always slow-start)

and entries in this table expire every so often


********

I'm hoping to find time to add to the ECN code so that my machine
will keep a list of peers that will not reply to ECN-enabled handshake
offers and will special-case them, rather than needing to turn ECN off
for everything.  To do this I will need to set up an expiring cache in
kernel space.  Any suggestion for which other kernel structures to
reuse code for this from?




-- 
                                           David Nicol 816.235.1187
                                            1,3,7-trimethylxanthine
