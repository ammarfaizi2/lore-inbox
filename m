Return-Path: <linux-kernel-owner+w=401wt.eu-S1751075AbWLNEXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWLNEXC (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 23:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWLNEXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 23:23:01 -0500
Received: from smtp141.iad.emailsrvr.com ([207.97.245.141]:58806 "EHLO
	smtp141.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbWLNEXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 23:23:00 -0500
X-Greylist: delayed 2142 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 23:23:00 EST
Message-ID: <4580C954.103@gentoo.org>
Date: Wed, 13 Dec 2006 22:47:32 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: davej@codemonkey.org.uk
CC: linux list <linux-kernel@vger.kernel.org>
Subject: amd64 agpgart aperture base value
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I'm working on a solution for 
http://bugzilla.kernel.org/show_bug.cgi?id=6350

Certain BIOSes are screwing with the K8 aperture base value. However, 
these systems work after booting into windows and then rebooting into Linux.

It originally appeared to be a bug specific to asrock motherboard based 
on nforce3, but further reports have shown that this bug also manifests 
on ASUS+nforce3 and ASUS+via.

The BIOS sets some high bits at address 0x94 of the PCI config space of 
the northbridge, which falls under AMD64_GARTAPERTUREBASE

My current approach at a solution involves identifying the buggy systems 
by southbridge, and then fixing the northbridge in a PCI quirk. However 
as more systems are being uncovered I don't feel so good about this 
approach.

In amd64-agp.c, would it be dangerous to remove the "aperture base > 4G" 
thing and instead simply only read the rightmost 7 bits to ensure the 
aperture base is always in range? (This is coming from someone with 
little AGPGART understanding...)

Alternatively do you have other suggestions for how the problem might be 
solved better?

Thanks!
Daniel

