Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUAEPC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUAEPC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:02:56 -0500
Received: from web13904.mail.yahoo.com ([216.136.175.67]:50528 "HELO
	web13904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261193AbUAEPCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:02:54 -0500
Message-ID: <20040105150252.13443.qmail@web13904.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Mon, 5 Jan 2004 07:02:52 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Any changes in Multicast code between 2.4.20 and 2.4.22/23 ?
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>besides wishing everybody a Happy new Year 2004, I have one question.
>Have there been any changes in the multicast handling between 2.4.20
>and 2.4.22/23? Maybe specific to the "tg3" driver?
>
>Reason for my question is that the Ganglia monitoring toolkit stopped
>working with 2.4.22/23 kernels. Apparently mulicatst get sent, but
>nothing is received.
>
>Any ideas?
>
>
>Thanks
>Martin

Hi,

 just realized the massive changes between 21 and 22. At least that is
answered :-) Question remains why no MC packets arrive in 2.4.22 and
later (checked with tcpdump). Is there anything that one has to enable
when running a newer kernel?

 One diffeernce is the output of "cat /proc/net/igmp". On my 2.4.20
kernel it looks like:

[qx29340@lpsdm16 ~]$ cat /proc/net/igmp
Idx     Device    : Count Querier       Group    Users Timer  Reporter
1       lo        :     0      V2
                                010000E0     1 0:F63C1223            0
2       eth0      :     1      V2
                                010000E0     1 0:F63C1225            0
3       eth1      :     2      V2
                                470B02EF     1 0:F63C2428            1
                                010000E0     1 0:F63C1225            0

 While on 2.4.22/23 it looks like:

qx29340@lpsdm20 linux-2.4.23-1-msc]$ cat /proc/net/igmp
Idx     Device    : Count Querier       Group    Users Timer Reporter
1       lo        :     0      V2
                                010000E0     1 0:FFFE5D5D           0
2       eth0      :     1      V2
                                010000E0     1 0:FFFE5D5D           0
3       eth1      :     2      V2
                                470B02EF     1 0:FFFF8D5D           0
                                010000E0     1 0:FFFE5D5D           0


 The difference seems to be the "reporter" flag for the 470B02EF
multicast group, which is exactely the adrress Ganglia uses.

Any ideas
Cheers
Martin
PS: Moved to linux-net

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
