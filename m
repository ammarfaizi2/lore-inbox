Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWJBS63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWJBS63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWJBS63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:58:29 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:8682 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S964881AbWJBS61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:58:27 -0400
Date: Mon, 2 Oct 2006 11:55:50 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Dan Williams <dcbw@redhat.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002185550.GA14854@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <20061002113259.GA8295@gamma.logic.tuwien.ac.at> <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com> <20061002124613.GB13984@gamma.logic.tuwien.ac.at> <20061002165053.GA2986@gamma.logic.tuwien.ac.at> <1159808304.2834.89.camel@localhost.localdomain> <20061002111537.baa077d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002111537.baa077d2.akpm@osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 11:15:37AM -0700, Andrew Morton wrote:
> On Mon, 02 Oct 2006 12:58:24 -0400
> > 
> > You have a mismatch between your wireless-tools, your kernel, and/or
> > wpa_supplicant.  WE-21 uses the _real_ ssid length rather than the
> > kludge of hacking off the last byte used previously.  Please ensure that
> > your tools, driver, and kernel are using WE-21.
> > 'cat /proc/net/wireless' should tell you what your kernel is using.
> > Getting the driver WE is a bit harder and you may have to look at the
> > source.
> 
> Jean, John: the amount of trouble which this change is causing is quite
> high considering that we're not even at -rc1 yet.  It's going to get worse.

	We have to split between the different issues we have seen.
	Tools issue (the wpa_supplicant problem). -> those can only be
fixed by people upgrading. Fortunately, there are not so many tools
affected, and new version of those tools were released last
April/May. As I said, most distro have those in the pipe.
	In-Kernel driver issues (the Orinoco driver problem). -> those
can be patched and fixed as we go along. I would not worry about
those.
	Out-of-kernel issues (the ipw3945 driver problem). -> those
drivers need to be updated. That's the problem of living outside the
kernel. Very often those drivers are reactive with respect to kernel
API changes, rather than pro-active, so there is not much we can do.

> It doesn't sound like it'll be too hard to arrange for the kernel to
> continue to work correctly with old userspace?

	Actually, it's impossible. New userspace can work across both
version, old userspace fails on new version.

	The whole point of the -rc process is to find problems and the
scope of it, there is no way I can know everything. At this point, we
can decide if WE-21 should go in 2.6.19 or wait for 2.6.20. But I know
that most Linux-Wireless people such as Dan and Jouni have been
waiting impatiently for those changes...

	Have fun...

	Jean
