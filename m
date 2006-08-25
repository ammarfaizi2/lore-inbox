Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWHYG07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWHYG07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWHYG07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:26:59 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:61850 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964841AbWHYG05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:26:57 -0400
Date: Fri, 25 Aug 2006 08:21:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: Adrian Bunk <bunk@stusta.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       David Howells <dhowells@redhat.com>, Jens Axboe <axboe@suse.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
In-Reply-To: <1156439763.3012.155.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.61.0608250807440.7912@yvahk01.tjqt.qr>
References: <32640.1156424442@warthog.cambridge.redhat.com> 
 <20060824152937.GK19810@stusta.de>  <1156434274.3012.128.camel@pmac.infradead.org>
  <20060824155814.GL19810@stusta.de>  <1156435216.3012.130.camel@pmac.infradead.org>
  <20060824160926.GM19810@stusta.de>  <20060824164752.GC5205@martell.zuzino.mipt.ru>
  <20060824170709.GO19810@stusta.de> <1156439763.3012.155.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Increasingly, these days, that approach has been failing due to all this
>Aunt Tillie crap. I tried turning off CONFIG_KALLSYMS the other day, but
>it took me a while to work out how. And the increasing use of 'select'
>is even worse.

menuconfig could include a feature which lists a dependency tree on the 
current option, that is, f.ex., hitting 'D' on CONFIG_INET_AH (IP: AH 
transformation) could 
give this screen:


--- Depends ---
[ ] Networking support
    [ ] TCP/IP networking
--- Selects ---
[*] CONFIG_XFRM
[*] Cryptogrpahic API
    --- HMAC support
    <M> MD5 digest algorithm
    <M> SHA1 digest algorithm
--- Selected by ---


And, now let's take a 'D' on CONFIG_CRYPTO_HMAC:

--- Depends ---
[*] Cryptographic API
--- Selects ---
--- Selected by ---
[*] Experimental
[*] Networking support
    [*] TCP/IP Networking
    [*] INET: AH transform
    [*] INET: ESP transform
    [*] INET6: AH transform
    [*] INET6: ESP transform
    [*] SCTP


So you can:
- enable any Depends to make CONFIG_INET_AH available
- see what it selects and cycle between <*> and <M> (if possible)
  for Selected options
- deselect all the Selected Bys to be able to unselect CRYPTO_HMAC
  itself[3]


[3] would be a tough thing because you can select with && and ||, in which 
case it should simply list all the options specified in the Kconfig without 
regard to && and || combinatinos.


Jan Engelhardt
-- 
