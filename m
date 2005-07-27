Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVG0XSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVG0XSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 19:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVG0XSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 19:18:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58823 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261214AbVG0XRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 19:17:20 -0400
Date: Wed, 27 Jul 2005 16:16:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Florian Engelhardt <flo@dotbox.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: system freezes for 0.2 to 0.5 seconds when reading
 /proc/acpi/thermal_zone/THRM/temperature
Message-Id: <20050727161605.5711fcf7.akpm@osdl.org>
In-Reply-To: <20050728002244.5163ac4a@localhost>
References: <20050728002244.5163ac4a@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Engelhardt <flo@dotbox.org> wrote:
>
> Hello,
> 
> first of all, sorry for the long headline.
> second:
> Every time, i try to do the following:
> cat /proc/acpi/thermal_zone/THRM/temperature
> the whole system looks up for a short period of time (something about
> 0.5s). realy everything, video and audio encoding, mouse and keyboard
> input, firefox playing a flash animation, ...
> I am also getting the following:
> Losing some ticks... checking if CPU frequency changed.
> 
> maybe these two things are belonging to each other.
> 
> I am using a 2.6.12-rc3-mm1 kernel on a amd64 with a nvidia nforce4
> mainboard.

It might help if you were to generate a kernel profile:

readprofile -r
for i in $(seq 10)
do
	cat /proc/acpi/thermal_zone/THRM/temperature
done
readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40

