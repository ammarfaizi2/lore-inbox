Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUIYSMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUIYSMN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 14:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269374AbUIYSMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 14:12:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:3729 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266892AbUIYSMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 14:12:10 -0400
Date: Sat, 25 Sep 2004 11:12:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Allison <jra@samba.org>
cc: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
In-Reply-To: <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409251108570.2317@ppc970.osdl.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org>
 <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1>
 <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1>
 <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Sep 2004, Linus Torvalds wrote:
> 
> Methinks you've been looking too much at what MS does over the wire, and 
> that has made you think that it makes total sense to send random numbers 
> over the wire. Maybe so - maybe it's how you have to think if you make a 
> samba server. But if so, just _say_ so, instead of making arguments that 
> make no sense.

Btw, if you want to send bytes instead of blocks, I don't care. The Linux 
client can easily do

	blocks = bytes >> 9;

and I'll be perfectly happy. But if the "bytes" count you send has no
actual real-life meaning (ie it didn't actually come from the underlying
filesystem at all), then don't bother. The client might as well do

	blocks = (filesize + 511) >> 9;

if that's what the server is (badly) mangling.

		Linus


