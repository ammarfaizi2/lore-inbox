Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbTJEM3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 08:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbTJEM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 08:29:52 -0400
Received: from johanna5.ux.his.no ([152.94.1.25]:54453 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP id S263090AbTJEM3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 08:29:51 -0400
Date: Sun, 5 Oct 2003 14:29:25 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Matt Mackall <mpm@selenic.com>, Steven French <sfrench@us.ibm.com>,
       James Morris <jmorris@intercode.com.au>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031005122925.GA4183@badne3.ux.his.no>
Reply-To: Erlend Aasland <erlend-a@ux.his.no>
References: <OF9C1504BB.5FB00D5A-ON87256DB3.0015672E-86256DB3.001798AE@us.ibm.com> <20031002113759.GA19824@badne3.ux.his.no> <Pine.LNX.4.58.0310041058000.5954@twinlark.arctic.org> <20031004182417.GC13573@waste.org> <Pine.LNX.4.58.0310041127020.5954@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310041127020.5954@twinlark.arctic.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/04/03 11:51, dean gaudet wrote:
> this CIFS patch alone replaces 89 lines with 250 lines of code!
... you forgot that if we find a nice way to use the CryptoAPI, we can
remove the old md4/md5 code: that makes 631 lines of code go away!

> the code does not look anywhere near as readable as the original.  but perhaps
> that's just because i've dealt with the same trivial MD5Init/Update/Final
> API for years.
I agree that it could have been a bit more readable.

It is trivial to wrap the code that deals with the CryptoAPI into nice
"helper" functions. For example the cifs_do_hash() function does exactly
that. Putting scatterlist setup into one function will probably help a
lot on code readability and code size.

> i gather a lot of this comes from the desire to have run-time selectable
> sw and hw implementations of various algorithms for "optimal" performance.
> but there generally isn't an optimal algorithm for all situations.
> for small short digests like passwords it's probably more overhead to
> use the cryptoapi than is saved from any blindingly fast implementation
> behind the scenes.
True, I agree that it's perhaps a bit overkill. Anyway, this is just a
project for me to learn more about the kernel; it's not like I have a
burning desire to convert CIFS to use the CryptoAPI ;-)

Regards
	Erlend
