Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbULEUyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbULEUyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbULEUyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:54:24 -0500
Received: from gate.ebshome.net ([64.81.67.12]:65243 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S261393AbULEUww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:52:52 -0500
Date: Sun, 5 Dec 2004 12:52:51 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Linh Dang <dang.linh@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][PPC32[NEWBIE] enhancement to virt_to_bus/bus_to_virt (try 2)
Message-ID: <20041205205251.GD3448@gate.ebshome.net>
Mail-Followup-To: Linh Dang <dang.linh@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3b2b32004120206497a471367@mail.gmail.com> <3b2b320041202082812ee4709@mail.gmail.com> <16815.31634.698591.747661@cargo.ozlabs.ibm.com> <3b2b32004120306463b016029@mail.gmail.com> <20041205101110.GC3448@gate.ebshome.net> <3b2b320041205111821527278@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b2b320041205111821527278@mail.gmail.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 02:18:45PM -0500, Linh Dang wrote:
> From a single virtual buffer, the DMA library will build a chained list of
> physically contiguous buffers (it  can be one or more physical buffers).
> All the DMA engines I'm familiar with (mpc8260, mpc8580, marvell, etc.)
> accept a list of physical buffers.
> 
> The decoding algorithm (from a single virtual buffer to a chained list of
> physical buffers) is dead simple.

So you gonna call virt_to_bus several times (for each page) and see 
whether you get new phys page or not? This could work, but for the 
common case of phys-continuous buffer it'll be suboptimal, i.e. you 
waste time calling virt_to_bus when it's not needed. TO make it better 
you have to move that range check from virt_to_bus and friends to your 
DMA library, in this case we end up in the same situation we are 
already :) - no need to modify virt_to_bus....

--
Eugene
