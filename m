Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWJVX3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWJVX3L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWJVX3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:29:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:9308 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750842AbWJVX3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:29:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T4Rh3sC0sMI1nPLSbbqil5UvOaTTkbaqa4A+PslKEb3zHeUlVp0BWGYnu4v4rO61pqjVTm08/pVhsaJDfmhPXCqbh9gk36tyLfeb4qVKgywu7DlaqZ8kxa6Bk7izlu1A4rcn5N/mWrBm7ut5ZqzVgo9a+avVcmGG8LGdKQSincs=
Message-ID: <4807377b0610221629kf820679re331b0a22ce05df4@mail.gmail.com>
Date: Sun, 22 Oct 2006 16:29:07 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: Strange errors from e1000 driver (2.6.18)
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <453BF19A.5020703@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453BBC9E.4040300@google.com> <453BC0E7.1060308@mbligh.org>
	 <4807377b0610221321i62455faende025f88142dd087@mail.gmail.com>
	 <453BD41B.4010007@google.com>
	 <4807377b0610221515m42e638c3pfb461fbb7133845e@mail.gmail.com>
	 <453BF19A.5020703@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/06, Martin J. Bligh <mbligh@google.com> wrote:
> Jesse Brandeburg wrote:
> > Analysis follows, but I wanted to ask you to bisect back if you can to
> > find the apparent patch to make the difference.  Basically at this
> > point I'd say its not likely to be an e1000 issue, but I'd like to
> > follow up and make sure.
>
> That's going to be ugly, since I can't reproduce it at will. Maybe if
> I netperf it to the other box I can push it over.

try tbench with 100 sessions (from dbench package) and see if that hurts.

> > Nothing seems out of order, but the latency may be low, I'd be curious
> > what these looked like before with the old kernel.  Some of the other
> > things to compare would have been the lspci -vv output from your
> > chipset with old/new kernel, in case the bridge/system configuration
> > changed.  There are no known problems right now with this chipset
> > 82546EB
>
> OK. will try later when I have more time. For now I switched to the
> onboard via rhine controller.

ouch.

> > shared int, fine, but whats with the ERR: ?
>
> Hmm. Having rebooted they look rather lower. but might be a time thing.
>
>             CPU0
>    0:    1405995          XT-PIC  timer
>    1:       5910          XT-PIC  i8042
>    2:          0          XT-PIC  cascade
>    5:          0          XT-PIC  uhci_hcd:usb3
>    7:      27135          XT-PIC  ehci_hcd:usb2, VIA8237, eth0
>   10:          0          XT-PIC  uhci_hcd:usb4, uhci_hcd:usb5,
> uhci_hcd:usb6
>   11:          0          XT-PIC  ehci_hcd:usb1, uhci_hcd:usb7,
> uhci_hcd:usb8
>   12:     157547          XT-PIC  i8042
>   14:      36296          XT-PIC  ide0
>   15:     196690          XT-PIC  ide1
> NMI:          0
> LOC:    1406006
> ERR:         26
>
> > except you didn't include any of the e1000 load information nor the
> > system's boot information as it came up.
>
> OK, it had gone since reboot, but I rebooted just now .... new info
> attached.
>
> > This chipset is one of the most frequent common elements in problem
> > reports of TX hangs for e1000.  My current theory (we've bought a
> > bunch of these systems and never reproduced the issue) is that there
> > is something either design specific or BIOS specific that causes this
> > chipset to interact very badly with e1000 hardware.  Some systems have
> > the issue and some don't.  If you could bisect back to a working point
> > it would be interesting to see where that pointed.
>
> OK, is going to be hard to bisect, since the other one was an Ubuntu
> kernel, but I guess I can give 2.6.15 virgin a shot, at least.

thanks, I know how difficult and time consuming bisecting is.

> > doesn't seem you're overclocked.  Good.
>
> Nah, I'm pretty conservative with hardware, get enough problems when
> it's all running within specs ;-)
>
> Thanks for looking at all this.

welcome, like to help when I can.

> Linux version 2.6.18 (mbligh@titus) (gcc version 3.4.6 (Ubuntu 3.4.6-1ubuntu2)) #2 Sun > e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
>   Tx Queue             <0>
>   TDH                  <26>
>   TDT                  <26>
>   next_to_use          <26>
>   next_to_clean        <39>
> buffer_info[next_to_clean]
>   time_stamp           <77145>
>   next_to_watch        <3b>
>   jiffies              <7734f>
>   next_to_watch.status <0>
> NETDEV WATCHDOG: eth0: transmit timed out
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex

hey, this one is different.  It is actually the common tx hang
signature (TDH == TDT) for these kinds of systems. I've come up with a
workaround driver, code is still in development.

you can try it if you would like.
http://sourceforge.net/tracker/download.php?group_id=42302&atid=447449&file_id=198849&aid=1463045

Thanks,
  Jesse
