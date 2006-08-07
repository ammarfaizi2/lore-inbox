Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWHGPKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWHGPKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWHGPKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:10:50 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:2835 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932131AbWHGPKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:10:49 -0400
Message-ID: <44D75786.8030603@shadowen.org>
Date: Mon, 07 Aug 2006 16:08:54 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 early_param mem= fix
References: <Pine.LNX.4.64.0608061811030.19637@blonde.wat.veritas.com> <Pine.LNX.4.64.0608061829430.20012@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0608061829430.20012@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Sun, 6 Aug 2006, Hugh Dickins wrote:
>> I was impressed by how fast 2.6.18-rc3-mm2 is under memory pressure,
>> until I noticed that my "mem=512M" boot option was doing nothing.  The
>> two fixes below got it working, but I wonder how many other early_param
>> "option=" args are wrong (e.g. "memmap=" in the same file): x86_64
>> shows many such, i386 shows only one, I've not followed it up further.
> 
> Oh, and that's not enough for it to show up in x86_64's /proc/cmdline.

Thats one I've been chasing and is caused by this same patch.  We've 
lost the separation between command_line and saved_command_line and the 
user visible line gets trunc'd.  Andi has a later version which has this 
part fixed as far as I can tell.  I'm posting a dirty patch in response 
to my report of this to at least get past this bit as our test system 
relies on the commmand line being maintained to user space.

-apw
