Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030625AbVJ1Sw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030625AbVJ1Sw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbVJ1Sw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:52:28 -0400
Received: from ns1.suse.de ([195.135.220.2]:25486 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030625AbVJ1Sw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:52:27 -0400
From: Andi Kleen <ak@suse.de>
To: Yinghai Lu <yinghai.lu@amd.com>
Subject: Re: x86_64: calibrate_delay_direct and apic id lift for BSP
Date: Fri, 28 Oct 2005 20:53:07 +0200
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linuxbios@openbios.org
References: <86802c440510281142i11771f25o3f6667869b4d614e@mail.gmail.com>
In-Reply-To: <86802c440510281142i11771f25o3f6667869b4d614e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510282053.07608.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 20:42, Yinghai Lu wrote:
> andi,
> 
> I tried to lift apic id in LinuxBIOS for all cpus after 0x10.
> 
> When using MB with AMD8111, the jiffies was not moving. So it is
> locked at calibrate_delay_direct...

Have you tried it with 2.6.14? It has some new code to handle
high apic ids better
 
> but  MB with Nvidia ck804, jiffies is moving.

The timer is wired different on nvidia than on 8111. They can
go either through the 8259 or through the IOAPIC.  There is still
some code that falls back to the 8259 if IOAPIC doesn't work,
which may make it appear working on Nvidia.

As a warning I'm about to remove that code so don't rely on it.

> If I don't change BSP apic id ( keep it to 0), It changes....
> 
> I have no idea how the jiffies changes, there is another thread change it....?

They change when interrupt 0 fires. So it's probably misrouted
or similar.


-Andi
