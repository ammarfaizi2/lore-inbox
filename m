Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUCKWPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 17:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCKWPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 17:15:20 -0500
Received: from fmr05.intel.com ([134.134.136.6]:43433 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261766AbUCKWPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 17:15:13 -0500
Message-ID: <4050E4D5.3@linux.co.intel.com>
Date: Thu, 11 Mar 2004 16:14:45 -0600
From: James Ketrenos <jketreno@linux.co.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
References: <404E27E6.40200@linux.co.intel.com> <20040311103754.540d9ca5@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040311103754.540d9ca5@dell_ss3.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> The whole /proc/ipw2100/xxx interface is ugly and a mess.  It doesn't expose anything
> really useful that can't be found other ways and it is buggy.  It doesn't handle
> more than one device;  I know you don't make hardware with multiple chipsets now but
> will that always be true?  

We're very interested in correcting any bugs you've found in the proc code.  If 
you have any more specifics it would be greatly appreciated (steps to reproduce 
the problem, what you're seeing that is problematic, etc.)

Multiple interfaces should be supported with the current code; each one's 
entries would show up in its own /proc/ipw2100/<if_name> directory.  The single 
debug_level entry in /proc/ipw2100 sets a global level for the entire driver 
module; we felt it more useful to apply the debug level globally to all 
potential ipw2100 devices than on a per device basis.  In the event that someone 
does have multiple ipw2100's in their machine and they want to be able to set 
the debug_level explicitly on a per device basis, we can accomodate that rather 
quickly in the code.  I'm interested in hearing other's opinions on this and am 
very willing to change the code if appropriate.

 > Also, it forgets to do properly set module owner.

Good catch; I'll fix it in the next snapshot.

> If you really have to keep the interface could you consider putting it in sysfs.
> Something like /sys/class/net/eth0/ipw2100/xxx with one value per file.
> The way to do that is with attribute groups.

Transitioning to sysfs is one of the goals as the project develops.

That said, we have a development mailing list set up for the project if you're 
interested in helping us improve the driver.  You can subscribe to that list 
here <http://lists.sourceforge.net/mailman/listinfo/ipw2100-devel>

Thanks for the feedback.

James
