Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVDCFrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVDCFrx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 00:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDCFrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 00:47:53 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:30728 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261178AbVDCFrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 00:47:51 -0500
Date: Sun, 3 Apr 2005 07:47:46 +0200
From: Willy Tarreau <willy@w.ods.org>
To: jmerkey <jmerkey@utah-nac.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 Adaptec 4 Port Starfire Sickness
Message-ID: <20050403054746.GA7858@alpha.home.local>
References: <424F73F8.8020108@utah-nac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424F73F8.8020108@utah-nac.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I've also experienced those messages under 2.4, but they were harmless,
and I never had a machine hang even after weeks of full load (the adapter
was mounted on a stress test machine before being used in firewalls for
months).

So I wonder how you can be sure that it is this driver which finally locks
the bus. Perhaps the system locks for any other reason (eg: race condition).
Have you tried with any other 4-port NIC (tulip or sun for example) ? Sun
QFE would be the most interesting to test as it also supports 64 bits /
66 MHz.

Regards,
Willy

On Sat, Apr 02, 2005 at 09:41:28PM -0700, jmerkey wrote:
> With linux 2.6.9 running at 192 MB/S network loading and protocol 
> splitting drivers routing packets out of
> a 2.6.9 device at full 100 mb/s (12.5 MB/S) simultaneously over 4 ports, 
> the adaptec starfire driver goes into
> constant Tx FIFO reconfiguration mode and after 3-4 days of constantly 
> resetting the Tx FIFO window and
> generating a deluge of messages such as:
> 
> ethX:  PCI bus congestion, resetting Tx FIFO window to X bytes
> 
> pouring into the system log file at a rate of a dozen per minute.  After 
> several days, the PCI bus totally locks up
> and hangs the system.  Need a config option to allow the starfire to 
> disable this feature.  At very
> high bus loading rates, the starfire card will completely lock the bus 
> after 3-4 days
> of constant Tx FIFO reconfiguration at very high data rates with 
> protocol splitting and routing.
> 
> Jeff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
