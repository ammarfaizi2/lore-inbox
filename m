Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267785AbUIKOg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267785AbUIKOg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 10:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUIKOg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 10:36:56 -0400
Received: from legaleagle.de ([217.160.128.82]:35719 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S267785AbUIKOgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 10:36:54 -0400
Message-ID: <41430D5E.9030207@trash.net>
Date: Sat, 11 Sep 2004 16:36:14 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [PATCH 2.6 NETFILTER] new netfilter module ipt_program.c
References: <20040911124106.GD24787@lkcl.net> <4142F4CC.7080708@trash.net> <20040911132935.GF24787@lkcl.net> <20040911133443.GG24787@lkcl.net>
In-Reply-To: <20040911133443.GG24787@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton wrote:
> On Sat, Sep 11, 2004 at 02:29:35PM +0100, Luke Kenneth Casson Leighton wrote:
> 
>  thing is, you see, i know just enough to be dangerous.
> 
>  using files->file_lock a) seems to work b) is accepted code in the
>  kernel.

It seems to work - on UP where it is a NOP. On SMP it will deadlock.
That we have some broken code doesn't mean we want more of it :)

>  if someone else has the experience and knowledge to fix ipt_owner.c
>  i'll quite happily cut/paste that instead - once it's fixed.

The "fix" is quite easy, replace all occurences of
spin_lock(&files->file_lock) in the kernel by spin_lock_bh.
But that's not going to be accepted. IIRC the SELinux guys
want to label packets with the name of the sending process,
maybe we can use this for the owner match once it's done.

Regards
Patrick
