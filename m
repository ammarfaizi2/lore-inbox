Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266889AbUAXHlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 02:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUAXHlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 02:41:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11703 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266884AbUAXHlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 02:41:22 -0500
Date: Fri, 23 Jan 2004 23:32:41 -0800 (PST)
Message-Id: <20040123.233241.59493446.davem@redhat.com>
To: grundler@parisc-linux.org
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20040124073032.GA7265@colo.lackof.org>
References: <20040124013614.GB1310@colo.lackof.org>
	<20040123.210023.74723544.davem@redhat.com>
	<20040124073032.GA7265@colo.lackof.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Grant Grundler <grundler@parisc-linux.org>
   Date: Sat, 24 Jan 2004 00:30:32 -0700

   My gut feeling is if linux aligns or pads things nicely for any reason,
   then the bye enables don't get used or clobber padding.
   
If the packet data length is an odd number of bytes, there is nothing
we can do about this, and the newer tigon3 chips are going to use a
cacheline burst for the end of the packet with the trailing byte
enables turned off.  I've seen this myself and sparc64 PCI controllers
generate a streaming byte hole error interrupt when it occurs and I
get messages logged in dmesg :)

   Maybe keep a shorter note about the bit changed meaning in later models
   just to document the issues.
   
We can "document it" by having the setting of this bit be protected by
chip version numbers.  I'd happily accept such a patch.
