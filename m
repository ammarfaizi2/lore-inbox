Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293595AbSBZUup>; Tue, 26 Feb 2002 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293580AbSBZUui>; Tue, 26 Feb 2002 15:50:38 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:38129 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S293542AbSBZUuY>;
	Tue, 26 Feb 2002 15:50:24 -0500
Date: Tue, 26 Feb 2002 13:50:06 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: george anzinger <george@mvista.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] enable uptime display > 497 days on 32 bit
Message-ID: <20020226135006.R12832@lynx.adilger.int>
Mail-Followup-To: george anzinger <george@mvista.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202261754030.14645-100000@gans.physik3.uni-rostock.de> <3C7BE53E.BB789BC6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7BE53E.BB789BC6@mvista.com>; from george@mvista.com on Tue, Feb 26, 2002 at 11:42:54AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  11:42 -0800, george anzinger wrote:
> Well, since you asked (thank you), the high-res-timers patch needs to
> get the full 64-bit uptime to implement CLOCK_MONOTONIC.
> This means that the 64-bit jiffies is used "often" in this code. 
> Unlike this patch, it keeps the 64-bit rational (i.e. always current)

Well, if you use the get_jiffies64() interface the 64-bit value is
always coherent as well, and the direct access to the 32-bit value
is monotonic.  While the high and low words of the 64-bit jiffies
values may be incoherent at times, as long as you always access the
64-bit value with the get_jiffies64() interface it should be OK.

Do you think that doing a 64-bit add-with-carry to memory on each
timer interrupt and doing multiple volatile reads is faster than
doing a spinlock with an optional 32-bit increment?  Do you think
there would be a lot of contention on this lock, given that you
only need to lock when you need the full 64-bit value?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

