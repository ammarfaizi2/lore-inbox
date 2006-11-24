Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934459AbWKXHFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934459AbWKXHFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 02:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934460AbWKXHFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 02:05:54 -0500
Received: from nz-out-0102.google.com ([64.233.162.204]:47675 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S934459AbWKXHFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 02:05:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=K1RYf9xyDDIBhqWfuqvFXaDq1kapHfSzVznfASKnRYslvV231DNkDNP8ZRpJFqRW42mvi653DLvMh1phob+FkxCTzBb+xlvoF1uOndbDbFBXPSCLpt35IaszcW00f861N+HLyScJPfUAutMv5SFQeO5kb+YZ/czgfKHkll6fl4Y=
Message-ID: <456699CA.9060904@gmail.com>
Date: Fri, 24 Nov 2006 16:05:46 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Conke Hu <conke.hu@amd.com>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       arjan@infradead.org
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
References: <FFECF24D2A7F6D418B9511AF6F3586020108CE7D@shacnexch2.atitech.com> <45668ACF.1040101@gmail.com>
In-Reply-To: <45668ACF.1040101@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Conke Hu wrote:
>> ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, 
>> AHCI and RAID. Legacy/Native IDE mode is designed for compatibility 
>> with some old OS without AHCI driver but looses SATAII/AHCI features 
>> such as NCQ. This patch will make SB600 SATA run in AHCI mode even if 
>> it was set as IDE mode by system BIOS.
[--snip--]
> Other than that, Acked-by: Tejun Heo <htejun@gmail.com>

At the second thought, I think this should be done in 
ahci_init_controller().

* Unlike Jmicron's case, this doesn't affect PCI bus scan.  Actually, it 
does change class code but that's not as disruptive as Jmicron's case 
and as long as ahci ignores class code, it doesn't really matter. 
Driver can be chosen by changing loading order - this is both plus and 
minus.

* As Arjan pointed out, that unlock-modify-lock sequence should be done 
on resume too.  ahci_init_controller() is the right place for such 
stuff.  This chip is going into notebooks, right?

-- 
tejun
