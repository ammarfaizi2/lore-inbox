Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTEVE5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 00:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTEVE5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 00:57:30 -0400
Received: from CPE-203-45-136-67.qld.bigpond.net.au ([203.45.136.67]:8204 "EHLO
	oxcoda.safenetbox.biz") by vger.kernel.org with ESMTP
	id S262278AbTEVE53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 00:57:29 -0400
Date: Thu, 22 May 2003 15:10:24 +1000
From: Menno Smits <menno@netbox.biz>
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic with pptpd when mss > mtu
Message-Id: <20030522151024.4a61c6a3.menno@netbox.biz>
In-Reply-To: <20030521180917.6f524e6f.menno@netbox.biz>
References: <20030521091442.1bfb41b6.menno@netbox.biz>
	<20030520214301.A3632@google.com>
	<20030521180917.6f524e6f.menno@netbox.biz>
Organization: NetBox
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SERVER01/Oxcoda/AU(Release 5.0.12  |February 13, 2003) at
 22/05/2003 03:10:24 PM,
	Serialize by Router on SERVER01/Oxcoda/AU(Release 5.0.12  |February 13, 2003) at
 22/05/2003 03:10:25 PM,
	Serialize complete at 22/05/2003 03:10:25 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Grab the latest ftp://ftp.samba.org/pub/unpacked/ppp which corrects both
> > of the above problems.
> 
> I'll try this and let you know how I go. 

Works beautifully, once I'd figured out the correct pppd options to
pass. Thank you. 

Curiously I couldn't get the server and client to use MS-CHAPv2 or
MPPE unless the "require-mschap-v2" and "require-mppe" options were
provided. I assumed the client and server would negotiate at the
'highest' common authentication and encryption level. Instead I found
I had to include these two options or else standard CHAP with no
encryption was used (or the connection failed totally if Windows was
told to _require_ encryption or MS-CHAP).

Some other observations:

- pptp connections seem more reliable now. Previously it could take
  several attempts before a PPTP connection could be established
  (particularly from Win98?). This seems to be fixed with this
  MPPE/MS-CHAP implementation or perhaps its something else in 2.4.2.
  Either way, good stuff!

- If I load the netfilter pptp connection tracking modules on the PPTP
  server I can't connect at all from Win98. Win2k works fine. Will
  test other clients soon. Lots of the following from poptop:

        GRE: xmit failed from decaps_hdlc: Operation not permitted

  ...even with no firewall rules active. Unload the conntrack modules
  it works fine. Strange! Previously, with the third party MPPE
  patches connection attempts were less reliable with the conntrack
  modules loaded but were workable. This is probably out of the scope
  of our discussion but any thoughts welcome :)

Its great to have MPPE and MS-CHAPv2 support in the main pppd dist
now... one less patch to worry about. Hopefully the MPPE kernel patch
will make it to the mainline kernel soon too.

Thanks for your help,
Menno 
