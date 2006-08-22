Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWHVG3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWHVG3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 02:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWHVG3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 02:29:30 -0400
Received: from stinky.trash.net ([213.144.137.162]:30448 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750857AbWHVG33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 02:29:29 -0400
Message-ID: <44EAA447.1080004@trash.net>
Date: Tue, 22 Aug 2006 08:29:27 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter@lists.netfilter.org
Subject: Re: ipt_MARK/xt_MARK usage problem
References: <Pine.LNX.4.61.0608220815560.24532@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608220815560.24532@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> kernel 2.6.17 ships with xt_MARK, but iptables 1.3.5 still uses ipt_MARK. 
> In essence, I cannot use `iptables -j MARK` giving me 
> 
> # iptables -A INPUT -j MARK --set-mark 1
> iptables: Unknown error 4294967295
> 
> I have seen this before and the problem behind this strange error (-1) is 
> that the .targetsize/.matchsize variables in the kernel modules do not 
> match their userspace parts.

No, its a bug in the iptables userspace version you're using, which
makes it report any error as "Unknown error 4294967295". The
error itself is that you're using MARK in the filter table.

> However, this time it seems to be something different:
> 
> # iptables -t mangle -A INPUT -j MARK --set-mark 1
> 
> Works without problems. Am I missing something?
> How do I get MARK back to work in -t filter -- possibly without hacking in 
> xt_MARK.c?

You won't, its not supposed to work in the filter table.

