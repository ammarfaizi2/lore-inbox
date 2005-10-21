Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVJUARd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVJUARd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVJUARd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:17:33 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:2296 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932560AbVJUARd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:17:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WDMegB1i6ssj/220yH9wn36RAPLNyxuZiF/8ip6XzQQs/Hb1CARMej7gHw4iOftaXStz73CBJfHYXv1abwN/VG/wubvO+sBqxeLgiHYXoix928CwvxtIpmaFEMTXBDWuqZeJdPbvpkOpgevbKM3iOR+NIB3Pct9qZQy7PFjqCEw=
Message-ID: <43583386.6070400@gmail.com>
Date: Fri, 21 Oct 2005 08:17:10 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Pozsar Balazs <pozsy@uhulinux.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vgacon blanking
References: <4ZLja-4gH-5@gated-at.bofh.it> <E1EShsL-0000tJ-Fr@be1.lrz>
In-Reply-To: <E1EShsL-0000tJ-Fr@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Pozsar Balazs <pozsy@uhulinux.hu> wrote:
> 
>> This patch fixes a long-standing vgacon bug: characters with the bright
>> bit set were left on the screen and not blacked out.
>> All I did was that I lookuped up some examples on the net about setting
>> the vga palette, and added the call missing from the linux kernel, but
>> included in all other ones. It works for me.
> 
> This is strange, since according to my documentation, the value should have
> been initialized to 0xff and never been changed. Can you test setting this
> value during initialisation (around line 259, if I read correctly) instead?
> I don't know if I can test it myself soon enough.

Actually, I don't see the palette mask (0x3c6) set anywhere in vgacon. The code
in line 259 sets the first 16 entries of the internal palette (0x3c0: 0x0-0xf)
so it points to the first 16 entries of the DAC.

Tony
