Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263331AbTIGJsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 05:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTIGJsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 05:48:32 -0400
Received: from gromit.aerasec.de ([195.226.187.57]:1698 "EHLO smtp2.aerasec.de")
	by vger.kernel.org with ESMTP id S263331AbTIGJsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 05:48:31 -0400
X-AV-Checked: Sun Sep  7 11:48:27 2003 smtp2.aerasec.de
Date: Sun, 07 Sep 2003 11:48:22 +0200
From: Peter Bieringer <pb@bieringer.de>
To: Zoltan NAGY <nagyz@nefty.hu>
Cc: usagi-users@linux-ipv6.org, linux-kernel@vger.kernel.org
Subject: Re: (usagi-users 02525) sit tunnel/iptunnel bug?
Message-ID: <17150000.1062928102@worker.muc.bieringer.de>
In-Reply-To: <FEEILOIHCEAEMLNJIDEJOELICFAA.nagyz@nefty.hu>
References: <FEEILOIHCEAEMLNJIDEJOELICFAA.nagyz@nefty.hu>
X-Mailer: Mulberry/3.1.0b6 (Linux/x86)
X-URL: http://www.bieringer.de/pb/
X-OS: Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, September 07, 2003 01:28:08 AM +0200 Zoltan NAGY
<nagyz@nefty.hu> wrote:

> hi!
> 
> i've got some really odd behavior.. if i do:
> ip tunnel add t12 mode sit remote 195.70.51.141 local 195.70.37.175 ttl 64
> then ip link set t12 up i got:
> RTNETLINK answers: No such device
> it must be a bug, because i only get this if i have another 12 or more
> tunnels added before this one.. and just with specific ip address, if i
> change it or simply use ip tunnel add t12 mode sit remote 195.70.51.141,
> then it's working..
> this problem exists in 2.4.20, and .22; .21 is not tested..
> is this a real bug? has anyone experienced it before?

This single command line works fine here. Perhaps you have used the same
destination a second time on tunnel "t12".

Check this, because of a bug in "ip", adding of tunnel with the same
destination silenty fails (exit code = 0).

This is why my initscript-ipv6 package checks whether destination address
is already applied on another tunnel.

        Peter
-- 
Dr. Peter Bieringer                     http://www.bieringer.de/pb/
GPG/PGP Key 0x958F422D               mailto: pb at bieringer dot de 
Deep Space 6 Co-Founder and Core Member  http://www.deepspace6.net/
