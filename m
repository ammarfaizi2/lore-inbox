Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264254AbUESPk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUESPk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUESPh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:37:28 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:25338 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264251AbUESPgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:36:11 -0400
Date: Wed, 19 May 2004 11:31:15 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Tigran Aivazian <tigran@veritas.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: overlaping printk
In-Reply-To: <Pine.LNX.4.44.0405191624240.4081-100000@einstein.homenet>
Message-ID: <Pine.GSO.4.33.0405191127050.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2004, Tigran Aivazian wrote:
>It happens to me often (on SMP) too. Originally I thought that printk is
>broken but having looked at the code I see that it has sufficient locking
>in place to prevent this from happening (on printk side). However, the
>fact that it only happens on a serial console (especially at low baud
>rates like 9600)  points in the direction of the serial driver.

(the port's @ 115.2k, btw)

That doesn't make sense.  printk is putting things in it's ring buffer
correctly, however the process that reads out of the buffer is reading
from two different points and unpredictably pushing them out the serial
port.

I'll go look at the code behind kseriod.

--Ricky


