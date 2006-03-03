Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWCCWn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWCCWn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWCCWn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:43:59 -0500
Received: from web81007.mail.mud.yahoo.com ([68.142.199.87]:54445 "HELO
	web81007.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750727AbWCCWn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:43:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:X-RocketYMMF:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Sc4aNjxd6oZz5iXQW/gR2rNwIRdpl7IGvKckqXQvaPSTwWFeoUZxGALLMRioZjAK0PAlSxSK6jW2c86azNPq57pg+gUrqniYVlc/KXuRDg9iA/DXQ55nH6PNuVQYNwF8jpv+4BLUO3EEvJw/c9lxlss/Kr4kDnOt4hLUvTCyoaY=  ;
Message-ID: <20060303224358.62126.qmail@web81007.mail.mud.yahoo.com>
X-RocketYMMF: dafox2@sbcglobal.net
Date: Fri, 3 Mar 2006 14:43:58 -0800 (PST)
From: Jerry Fox <spblaguard-linux@yahoo.com>
Reply-To: spblaguard-linux@yahoo.com
Subject: Ability to change MSS using TCP_MAXSEG
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

I'll post this time with mentioning "advertised" MSS
in the subject  :-)

I have a question about the advertised MSS and the
TCP_MAXSEG setsock option.   Note: I am using the
Stevens sock code (http://www.unpbook.com/src.html) to
do testing.  

I set the TCP_MAXSEG via –X to 256 (yes, I
intentionally want poor performance), and used gdb to
verify that setsockopt gets called before the
connect() call, as described in the tcp (7) manpage. 
However, Ethereal shows the advmss is still 1460.  
Looking in the kernel
(net/ipv4/tcp_output.c::tcp_connect_init), I can see
the mss_clamp gets the user_mss, but the advmss is
still calculated based on dst_metric.  Host route MTU
settings and interface MTU settings work as expected,
but is there a way to advertise a different MSS per
session/socket? 

For ref, I see the same behavior on:
IA64+Debian/HPCGL+2.4.20
X86+Fedora+2.6.15
PPC+MontaVista+2.6.14

Please cc: me personally on any replies.

Thanks!
Jerry Fox
 


