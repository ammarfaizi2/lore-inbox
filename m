Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268321AbUJDCPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268321AbUJDCPr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 22:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUJDCPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 22:15:47 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:35814 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S268321AbUJDCPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 22:15:45 -0400
Date: Sun, 3 Oct 2004 19:15:45 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andi Kleen <ak@muc.de>
cc: Florian Bohrer <Florian.Bohrer@t-online.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH] AES x86-64-asm impl.
In-Reply-To: <m3acv4zz5f.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.61.0410031856030.17980@twinlark.arctic.org>
References: <2KWl4-wq-25@gated-at.bofh.it> <m3acv4zz5f.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Oct 2004, Andi Kleen wrote:

> Unfortunately it's still fundamentally 32bit. Anybody interested
> in doing a true 64bit AES?

i doubt it helps any -- except for benchmark-only purposes.

there's a description of the 32-bit T-table approach in section 7.3 of 
<http://fp.gladman.plus.com/cryptography_technology/rijndael/aesspec.pdf>

basically the tables are 8-bit -> 32-bit maps, and there are 4 of them (2 
for each direction).  to go to 64-bit you'd need 16-bit -> 64-bit maps... 
512KiB per table.  there are some other variations on the tables which are 
smaller, but nothing as small as the 1024 bytes per table of the 32-bit 
implementation.

there's a completely different approach using bit-slicing (basically 
consider each register as 64 1-bit registers), which yields great 
throughput but cruddy latency -- you basically need lots of non-dependant 
streams to make this pay off (i.e. it might work for disk crypto 
processing multiple blocks simultaneously).

-dean
