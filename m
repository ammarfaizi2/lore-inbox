Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVKOL6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVKOL6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 06:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVKOL6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 06:58:25 -0500
Received: from barclay.balt.net ([195.14.162.78]:17741 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S932381AbVKOL6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 06:58:24 -0500
Date: Tue, 15 Nov 2005 13:56:57 +0200
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Andrew Morton <akpm@osdl.org>
Cc: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, yi.zhu@intel.com,
       jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
Message-ID: <20051115115657.GA30489@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115100519.GA5567@gemtek.lt>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

Compiled and installed the latest snapshot. Rebooted and started in
single mode. During boot the following versions are reported :
 
 ipw2200 driver  git-1.0.8,
 ieee80211 stack git-1.1.7. 
 
The following configuration options (under "kernel hacking" menu) have 
been enabled:

CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_4KSTACKS=y

Then - I simply ran wpasupplicant (version 0.4.6). Simple sequence:

wpa_supplicant -Dwext -ddd -i eth0 -c wpa.conf 
<scan / assoc - attempts to authenticate ...>
then Control-C 

So far so good. No problem. 

Then try again several times :

wpa_supplicant -Dwext -ddd -i eth0 -c wpa.conf 
<scan / assoc - attempts to authenticate ...>
then Control-C 

Eventually kernel will freeze (I can trigger this reliably, tried 3
times and it "worked" 3 times as well). Although I've seen no error message 
printed to console - sysrq-T always shows the same stack trace (in
wpa_supplicant context:

ipw_request_direct_scan
__change_page_attr
poison_obj
dbg_redzone1
autiremove_wake_function
ipw_wx_set_scan+0x7f/0x81
copy_from_user
wirelees_process_ioctl
ipw_wx_set_scan+0x0/0x81
sock_ioctl
do_ioctl
vfs_ioctl
sys_ioctl
sysenter_past_esp

http://www.gemtek.lt/~zilvinas/backtrace.jpg 

Zilvinas Valinskas


On Tue, Nov 15, 2005 at 12:05:19PM +0200, Zilvinas Valinskas wrote:
> Hello, 
> 
> I am compiling the latest git snapshot 4060994c3e337b40e0f6fa8ce2cc178e021baf3d.
> I will let you know if anything comes up.
> 
> Z.
> 
> On Mon, Nov 14, 2005 at 04:29:42PM -0800, Andrew Morton wrote:
> > This looks like some sort of slab scribble, possibly caused by faulty
> > error-path handling in the ipw2200 code.
> > 
> > Please enable CONFIG_DEBUG_SLAB and see if that picks anything up.
> > 
> > Also enable CONFIG_DEBUG_PAGEALLOC.
> > 
> > You may also get more info by setting CONFIG_IPW_DEBUG and loading the
> > module with `debug=65535' (guess).
> > 
> > Whatever you do, don't fix the firmware loading failure (sorry).  Doing
> > that will cause you to not be able to reproduce this bug ;)
> 
> Hmmm, I didn't see any problems related to f/w loading ...
> 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
