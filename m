Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWAZUGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWAZUGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWAZUGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:06:30 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:6742 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751397AbWAZUG3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:06:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rosUlpI3BCBHPIjereXas9xNgvJhYPIYnQ5uL/aBzNsAJycuwBwmvPHclevlobDk5TNgLS+/fCF+JbF4JY1tLfvxAJ0tvjuIFz/pG3ntiVqxiQJUkQFTYZV7TC84M0Uwq4sapFj/gfjabK/qrPB5wpHvEfqh1hv80cRgpc7oocE=
Message-ID: <7d40d7190601261206wdb22ccck@mail.gmail.com>
Date: Thu, 26 Jan 2006 21:06:28 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

I'm quite a newbie in the kernel development, but I'm writing a kernel
module and would like to do the things right. What I'm trying to do
is, more or less, a kind of "virtual" network device (not really that
but it will suffice).

This network device can be configured from userspace. I have read the
books "Linux Device Drivers 3" (LDD3) and "Linux Kernel Development"
and after that I didn't find the answer to the question I was making
myself: What should be the right way to configure it?

In LDD3 it says that ioctls fall out of favor among kernel developers,
but there is not a  strong _advise_ to use another method. It says
that instead of that sysfs _could_ be used. Of course, that was almost
a year ago. I'm sure things have changed since then.

So, well, I did all this configuration using ioctls and proc, which
was the fastest for me, but may be not the best solution. So I'm
asking for advise here.

The configuration I need to do is actually quite simple. Most of the
commands are just set or get a variable defined in my module (for
example, write to a flags variable, just like in real network devices
-- i.e. IF_UP). The most difficult "config" I need to do is write a
struct to the module (just write two variables in the same command).

What way do you suggest for all this? Is sysfs correct for this? What
about the new filesystem "configfs"? I've just heard about it, but I
don't even have it mounted on my system. Would it be what I need?

On the other hand, I also need to export some statistics to userspace.
These are similar to the ones in a network device: packets received,
dropped,... but I would like to export not just the number of packets
received, but the number received by _each_ cpu, as well as the total.
Would you recommend me /proc or sysfs?

In case of using sysfs, would this be the correct approach or you
would recommend  one value per file?
$ cat rx_packets
     10     15     25
where the first value is packets received in CPU0, the second in CPU1
and the last the total.


Thank you for your time
Regards
Aritz
