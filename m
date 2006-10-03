Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWJCSOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWJCSOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWJCSOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:14:12 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:25869 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751023AbWJCSOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:14:10 -0400
Date: Tue, 3 Oct 2006 14:05:50 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jeff@garzik.org,
       johannes@sipsolutions.net, jt@hpl.hp.com
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003180543.GD23912@tuxdriver.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 09:27:34AM -0700, Linus Torvalds wrote:

> We don't do this version skew dance. If we need to break something, it had 
> better be some damn substantial reasons, and even then we're generally 
> better off supporting _both_ interfaces for a while (perhaps using a 
> version code), and then marking the old one deprecated.
 
FWIW, this clean-up is not intended to break older binaries.
It is intended to standardize driver implementations of the WE API.
Breakage is (merely!) a side-effect...

The overall purpose of the WE-21 patch was to continue disambiguating
how drivers implement the WE API.  This is intended to (hopefully)
avoid strange, hidden bugs lurking out there in driver/tool
interaction, especially for tools other than wireless-tools
(e.g. NetworkManager, wpa_supplicant, etc).  In this case, it looks
like maybe some older versions of these tools were effectively
exploting the strange, hidden bugs... :-(

It seems there were a few genuine bugs which crept into the WE-21
implementation.  Jean has posted fixes for those today.  It looks
like those patches get things working again when combined with
updated tools.

Today's news seems to indicate that at least the major distros are
already shipping the updated tools, or on the verge of shipping them.
The window of breakage for most users looks like it will be fairly
small, no matter what action taken.

The more we can clean-up the WE API, the easier it will be to implement
the cfg80211 WE compatibility layer intended for wireless-dev.
I think WE-21 makes things better in that respect.

Finally, I already scaled-back Jean's original WE-21 patch.  I only
anticipate minor bug fixes for WE from now on, with nl80211/cfg80211
as the heir-apparent.

With all that said, I'd prefer to keep the existing WE-21 patches and
add Jean's fixes ASAP.  Is this acceptable?  If not, I'll submit the
reversions to Jeff ASAP.

Suggestions?

John
-- 
John W. Linville
linville@tuxdriver.com
