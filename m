Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbVJUAB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVJUAB2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 20:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVJUAB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 20:01:28 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:34678 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932557AbVJUAB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 20:01:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JhE9rsglBU2e6IBaJd2H3T4iSpRixfqZtPJbuXrtBgmx7xQru30YA7tJwM53EJX3NdOe4IqmIISiKXyZ1cdQB7ubx5jzmTvqYegkVH68cj58OA953O50QYtEBdQm720CmrWCIDDEaVzHcGGavk6ajaG5xefAwOwYNKN5VZReW/s=
Message-ID: <43582FBF.1070406@gmail.com>
Date: Fri, 21 Oct 2005 08:01:03 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@uhulinux.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vgacon blanking
References: <20051020161311.GA30041@ojjektum.uhulinux.hu>
In-Reply-To: <20051020161311.GA30041@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:
> Hi all,
> 
> This patch fixes a long-standing vgacon bug: characters with the bright 
> bit set were left on the screen and not blacked out.

I cannot reproduce the bug though, so this bug probably depends on the
chipset implementation of VGA. Everything works perfectly whatever value
is written to 0x3c6, so this register is either ignored or hardwired to
0xff.

> All I did was that I lookuped up some examples on the net about setting 
> the vga palette, and added the call missing from the linux kernel, but 
> included in all other ones. It works for me.
> 
> You can test this by writing something with the bright set to the 
> console, for example:
>   echo -e "\e[1;31mhello there\e[0m"
> and then wait for the console to blank itself (by default, after 10 mins 
> of inactivity), maybe making it faster using
>   setterm -blank 1
> so you only have to wait 1 minute.

The patch is obviously correct, and makes vgacon safe from rogue apps
that sets the the palette mask register to a different value.

> 
> 
> Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>
Acked-by: Antonino Daplas <adaplas@pol.net>

