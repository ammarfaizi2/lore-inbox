Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271688AbTHDOrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271754AbTHDOrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:47:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64270 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271688AbTHDOrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:47:39 -0400
Date: Mon, 4 Aug 2003 15:47:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jani Monoses <jani@iv.ro>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: ide-cs stack_dump
Message-ID: <20030804154731.C25847@flint.arm.linux.org.uk>
Mail-Followup-To: Jani Monoses <jani@iv.ro>, linux-kernel@vger.kernel.org,
	B.Zolnierkiewicz@elka.pw.edu.pl
References: <20030804174828.08dfc5f4.jani@iv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030804174828.08dfc5f4.jani@iv.ro>; from jani@iv.ro on Mon, Aug 04, 2003 at 05:48:28PM +0300
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 05:48:28PM +0300, Jani Monoses wrote:
> Hi
> as reported by someone earlier this year there's a long stack_dump
> starting from kobject_register failed with -17 (EEXISTS) when ide-cs
> detects a CF card.
> The reason is as I see it that both rescan_partitions and register_disk
> are called, both of which in turn call add_partition for all partitions
> on the CF card. add_partition calls kobject_register. Also devfs_mk_bdev
> is called twice but it only prints an error msg 'could not append...'. I
> don't know if that is how things should be called or whether kobjects
> for IDE are broken as Alan responded to that earlier post but apart from
> this initial stack_dump the card works fine (not eject of course) So is
> kobject_register to verbose or calling code should make sure it does not
> attempt to register the same object multiple times?

You can't kobject_register the same object multiple times.

What you're describing above sounds to me like an IDE problem.  It might
be worth discussing this with Bart. (cc'd)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

