Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbULaMi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbULaMi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbULaMi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:38:58 -0500
Received: from mail.portrix.net ([212.202.157.208]:55960 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261969AbULaMi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:38:56 -0500
Message-ID: <41D5485A.4060709@ppp0.net>
Date: Fri, 31 Dec 2004 13:38:50 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.6.10-ac1
References: <1104103881.16545.2.camel@localhost.localdomain> <200412302006.19872.gene.heskett@verizon.net> <41D52275.8030100@ppp0.net> <200412310705.52976.gene.heskett@verizon.net>
In-Reply-To: <200412310705.52976.gene.heskett@verizon.net>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> If I feed it the lines with the numbers it reports something about an 
> invalid IP on restart.
> 
> [root@coyote root]# parsemce -e Bank 2: d40040000000017a -b Bank 2: -s 
> d40040000000017a
> Status: (ba) Error IP valid
> Restart IP invalid.
> 
> The exact same output is obtained from the Bank 1 message & numbers 
> too.

Try

$ ./parsemce -e 0xba -b 2 -s d40040000000017a -a 0
Status: (ba) Error IP valid
Restart IP invalid.
parsebank(2): d40040000000017a @ 0
        External tag parity error
        Correctable ECC error
        Address in addr register valid
        Error enabled in control register
        Error overflow
        Memory heirarchy error
        Request: Generic error
        Transaction type : Generic
        Memory/IO : I/O

See [1] for a possible explanation. I hope the link works. It's a message
from DaveJ about the same error:
"Looks like the L2 cache ECC checking spotted something going wrong,
and fixed it up. This can happen in cases where there is inadequate
cooling, power, or overclocking (or in rare circumstances, flaky CPUs)"

Jan

[1] http://groups-beta.google.com/group/linux.kernel/browse_thread/thread/bbf1d32da11eb369/8b2300b83ac0ab9e?q=%22Restart+IP+invalid%22&_done=%2Fgroups%3Fq%3D%22Restart+IP+invalid%22%26hl%3Den%26lr%3D%26client%3Dfirefox%26rls%3Dorg.mozilla:en-US:unofficial%26sa%3DN%26tab%3Dwg%26&_doneTitle=Back+to+Search&&d#8b2300b83ac0ab9e
