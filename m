Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVBIAiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVBIAiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 19:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVBIAiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 19:38:04 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:20896 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261718AbVBIAhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 19:37:55 -0500
Date: Tue, 8 Feb 2005 16:37:54 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: jon ross <jonross@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM disk cache behavior.
Message-ID: <20050209003754.GA7298@hexapodia.org>
References: <e130a7170502080906596561d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e130a7170502080906596561d7@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 12:06:14PM -0500, jon ross wrote:
> I have an app with a small fixed memory footprint that does a lot of
> random reads from a large file. I thought if I added more memory to
> the machine the VM would do more caching of the disk, but added memory
> does not seem to make any difference. I played with some of the params
> in /proc/sys/vm and none of them seem to have any effect.
> 
> I tired both a 2.4.20 & 2.6.10 kernels with no difference.
> 
> The machine is a Dell 2560. I tired memory configs of 512M, 1G, 4G and
> the average read-times do not change.

Could we get some quant here?  How small is "small"?  How large is
"large"?  What are you measuring?  What are the results?  Does the app
re-use the same data, or is its use a one-time deal?

> Do I need to set/compile anything to allow the VM to use the memory?

No, the Linux VM system should automatically cache for you.

> If is was a way to tell how much memory the VM is using for a drive
> cache I could at least tell if my kernel is miss-configured or my app
> sucks.

Check out the commands "free", "vmstat 1", "top", the contents of
/proc/meminfo, the output of Sysrq-M.

Most likely is that your app isn't behaving in a cache-friendly way.  If
your file will fit in memory, just fault it in sequentially (wc -l file)
and then your app should cook.  If you're not going to fit in memory,
the vm caching will probably only help if you have some reuse; you could
develop a pre-faulter to get your IO started ahead of time, but that's
generally nontrivial.

-andy
