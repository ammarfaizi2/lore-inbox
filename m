Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVGVPlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVGVPlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 11:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVGVPlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 11:41:50 -0400
Received: from main.gmane.org ([80.91.229.2]:60887 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261297AbVGVPlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 11:41:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joy Leima <jleima@comcast.net>
Subject: Re: Re[2]: kernel oops, fast ethernet bridge, 2.4.31
Date: Fri, 22 Jul 2005 15:13:33 +0000 (UTC)
Message-ID: <loom.20050722T171013-389@post.gmane.org>
References: <20050720170025.1264b68a.lspaleniak@wroc.zigzag.pl> <20050720194457.GR8907@alpha.home.local> <273347727.20050720223316@wroc.zigzag.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 216.23.87.58 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007 Firebird/0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Spaleniak <lspaleniak <at> wroc.zigzag.pl> writes:

> 
> On Wednesday, July 20, 2005, 9:44:57 PM, Willy Tarreau wrote:
 > changed. At least it should have been oopsing from day one.
> It is strange to me too. There is no dependency when it happens.
> Sometimes traffic is small, sometimes it's normal. Packet rates are
> around ~2000-3000 pkt/sec - so not so high.
> 
> Regards,
> Lukasz
> 
Lukasz,

I think I have a fix for you.  Verify for me that it is the same problem.  Send
a large UDP packet through the bridge.  I believe the problem is the ip_fragment
code is not taking into account the VLAN header that needs to be added to the
packet when it gets fragmented on the way out.   

Just send the large UDP packet through the bridge.  I use ttcp.  If it panics
then I can send you the fix.  There are further changed to ip_output.c


