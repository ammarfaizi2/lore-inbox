Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVGFVfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVGFVfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbVGFVfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 17:35:13 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:40340 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262534AbVGFVcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 17:32:13 -0400
Date: Wed, 6 Jul 2005 23:29:25 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Juha Laiho <Juha.Laiho@iki.fi>, Andrew Hutchings <info@a-wing.co.uk>,
       linux-kernel@vger.kernel.org, lars.vahlenberg@mandator.com,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050706212925.GA4718@electric-eye.fr.zoreil.com>
References: <10201100.1120665539318.JavaMail.www@wwinf1506>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10201100.1120665539318.JavaMail.www@wwinf1506>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> That one works perfectly; i tried it in the same conditions as
> the previous patch, and i don't notice a regression.

Nice.

[...]
> sis190-010.patch does not compile properly :

Point taken. Thanks.

[...]
> But i get those traces in syslog, when the driver is
> loaded and every time i use ethtool :
> 
> [...]
> scheduling while atomic: mii-tool/0x00000001/4699

spinlock + msleep in __mdio_cmd()... Completely stupid.

The patchkit of the day should fix these issues:
http://www.zoreil.com/~romieu/sis190/20050706-2.6.13-rc1/patches

Tarball:
http://www.zoreil.com/~romieu/sis190/20050706-2.6.13-rc1.tar.bz2

Please shake it. You should be able to modify the set of displayed
messages with ethtool.

I'd appreciate if you could check the allowed frame size range, say
ping -s 1468 ... ping -s 1473 to compare with Lars's results.

You can add something like a ping -q -l 48 -s 64 -f to your tests and
increase the 48 and NUM_{RX/TX}_DESC but I am not sure that the remote
8139 will be able to go terribly far. If it performs well, pktgen
could be useful too.

Lars, can you describe the second host that you have used so far for
the tests:
- which nic ?
- which kernel ?

(on an unrelated note, something enabled the "send mail as html" checkbox
in your mail user agent: you may consider removing it).

--
Ueimor
