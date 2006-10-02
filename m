Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965369AbWJBTWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965369AbWJBTWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965370AbWJBTWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:22:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965369AbWJBTWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:22:47 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Dan Williams <dcbw@redhat.com>
To: jt@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
In-Reply-To: <20061002185550.GA14854@bougret.hpl.hp.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <20061002113259.GA8295@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com>
	 <20061002124613.GB13984@gamma.logic.tuwien.ac.at>
	 <20061002165053.GA2986@gamma.logic.tuwien.ac.at>
	 <1159808304.2834.89.camel@localhost.localdomain>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002185550.GA14854@bougret.hpl.hp.com>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 15:22:03 -0400
Message-Id: <1159816923.12691.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 11:55 -0700, Jean Tourrilhes wrote:
> On Mon, Oct 02, 2006 at 11:15:37AM -0700, Andrew Morton wrote:
> > On Mon, 02 Oct 2006 12:58:24 -0400
> > > 
> > > You have a mismatch between your wireless-tools, your kernel, and/or
> > > wpa_supplicant.  WE-21 uses the _real_ ssid length rather than the
> > > kludge of hacking off the last byte used previously.  Please ensure that
> > > your tools, driver, and kernel are using WE-21.
> > > 'cat /proc/net/wireless' should tell you what your kernel is using.
> > > Getting the driver WE is a bit harder and you may have to look at the
> > > source.
> > 
> > Jean, John: the amount of trouble which this change is causing is quite
> > high considering that we're not even at -rc1 yet.  It's going to get worse.
> 
> 	We have to split between the different issues we have seen.
> 	Tools issue (the wpa_supplicant problem). -> those can only be
> fixed by people upgrading. Fortunately, there are not so many tools
> affected, and new version of those tools were released last
> April/May. As I said, most distro have those in the pipe.
> 	In-Kernel driver issues (the Orinoco driver problem). -> those
> can be patched and fixed as we go along. I would not worry about
> those.
> 	Out-of-kernel issues (the ipw3945 driver problem). -> those
> drivers need to be updated. That's the problem of living outside the
> kernel. Very often those drivers are reactive with respect to kernel
> API changes, rather than pro-active, so there is not much we can do.
> 
> > It doesn't sound like it'll be too hard to arrange for the kernel to
> > continue to work correctly with old userspace?
> 
> 	Actually, it's impossible. New userspace can work across both
> version, old userspace fails on new version.
> 
> 	The whole point of the -rc process is to find problems and the
> scope of it, there is no way I can know everything. At this point, we
> can decide if WE-21 should go in 2.6.19 or wait for 2.6.20. But I know
> that most Linux-Wireless people such as Dan and Jouni have been
> waiting impatiently for those changes...

Right; we need to get this settled and we need to figure out a way with
Wireless Extensions to allow exact SSIDs to be sent and retrieved from
the card/driver.  How much cruft do we add to drivers and/or WE bits to
bend over backwards and preserve compatibility with a lot of older bits?
I can think of a few ways here to preserve backwards compat, but most
involve adding bits to 3 places in each driver and a new flag to WE,
which puts us right back in the same situation we're in right now;
inconsistent drivers and poor semantics both inside and outside the
kernel.

Maybe the answer here _is_ to bend over backwards to preserve
compatibility, restore null-termination-and-increment-length bits in
drivers and WE, and kludge all the user-space tools.  Then just Do The
Right Thing with nl80211/cfg80211 (whenever they come around) and fix
stuff up in the nl80211 WE compat layer.  I don't know.  But nl80211
isn't here yet, and it's unclear when it will be.

Dan

> 	Have fun...
> 
> 	Jean

