Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266288AbUFPM5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266288AbUFPM5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUFPM5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:57:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266288AbUFPMzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:55:22 -0400
Message-ID: <40D0432A.1080006@pobox.com>
Date: Wed, 16 Jun 2004 08:55:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
 or address)
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> <20040616095805.GC14936@gemtek.lt>
In-Reply-To: <20040616095805.GC14936@gemtek.lt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas wrote:
> On Compaq N800 EVO notebook with a radeonfb enabled - stty failes to
> adjust terminal size. strace log attached. Under 2.6.5/2.6.6 it used to
> work. 
> 
> relevant part:
> 
> open("/dev/vc/1", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
> fcntl64(3, F_GETFL)                     = 0x8800 (flags
> O_RDONLY|O_NONBLOCK|O_LARGEFILE)
> fcntl64(3, F_SETFL, O_RDONLY|O_LARGEFILE) = 0
> ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo
> ...}) = 0
> ioctl(3, TIOCGWINSZ, {ws_row=65, ws_col=175, ws_xpixel=0, ws_ypixel=0})
> = 0
> ioctl(3, TIOCSWINSZ, {ws_row=50, ws_col=175, ws_xpixel=0, ws_ypixel=0})
> = -1 ENXIO (No such device or address)
> write(2, "/bin/stty: ", 11)             = 11
> write(2, "/dev/vc/1", 9)                = 9
> open("/usr/share/locale/locale.alias", O_RDONLY) = 4
> 
> 
> it makes no difference when doing :
> 
> stty rows 50 columns 140 
> or
> stty rows 50 columns 140 -F /dev/vc/1 ... 
> 
> Exactly same error.


huh, I wonder if this is why reset(1) doesn't fully reset the terminal, 
like it used to ...

	Jeff


