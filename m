Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265802AbUFDSBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265802AbUFDSBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUFDSBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:01:50 -0400
Received: from palrel12.hp.com ([156.153.255.237]:2235 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265802AbUFDSBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:01:48 -0400
Date: Fri, 4 Jun 2004 11:01:06 -0700
To: Netdev <netdev@oss.sgi.com>, hostap@shmoo.com, prism54-devel@prism54.org,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Prism54 WPA Support - wpa_supplicant - Linux general wpa support
Message-ID: <20040604180106.GA19181@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040602071449.GJ10723@ruslug.rutgers.edu> <20040602132313.GB7341@jm.kir.nu> <20040602155542.GC24822@ruslug.rutgers.edu> <20040603165233.GC8770@bougret.hpl.hp.com> <20040604023303.GB7537@jm.kir.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604023303.GB7537@jm.kir.nu>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 07:33:03PM -0700, Jouni Malinen wrote:
> On Thu, Jun 03, 2004 at 09:52:33AM -0700, Jean Tourrilhes wrote:
> 
> > 	So, the plan would be to take Jouni's API as is (or with minor
> > modifications) and stuff that in wireless.h. I don't believe that the
> > tools themselves need to be modified, because wpa_supplicant is the
> > sole user of those ioctls.
> > 	If you are all happy with that, then I'll just do it.
> 
> I'm mostly happy with this, but this should also include something from
> the private ioctls hostapd uses for AP functionality.

	Obviously we need the full functionality, not just some part
of it.

> In addition, I would consider changing couple of text based elements
> (e.g., WPA IE as hex string) to binary in order to remove extra
> parsing code and make the data contents smaller.

	The downside of that is that things need to be predefined. As
we are doing a "WPA API" and not a "generic link layer security API",
that's OK.
	The other thing you may want to think about is miving all
string/arrays at the end of the definition so that we can grow them
easily if needed, and so that the first part can be fixed.

> I'm having quite a bit of problems with scan
> results getting too large for the current limit of 4 kB.. Admittedly,
> this is in a test lab environment, but still, it is annoying and
> requires workarounds like driver side filtering of the scan results.

	That's easy to fix. I did the same with "iwpriv" definitions a
couple of weeks ago. Basically, you return -E2BIG to user space until
userspace give you a big enough buffer.
	I'll try to fix that.

> I could try to make a list of all private ioctls currently used in
> wpa_supplicant and hostapd, including some comments on what I would
> consider changing at this point (mostly, changing text binary for couple
> of cases and removing some fields that are not really going to be used).

	You currently have your plate pretty full. I'll try to help,
but my first son was born one month ago and things are not as smooth
as planned.

> Jouni Malinen

	Jean
