Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBPEtl>; Thu, 15 Feb 2001 23:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129126AbRBPEta>; Thu, 15 Feb 2001 23:49:30 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:62141 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129108AbRBPEtM>; Thu, 15 Feb 2001 23:49:12 -0500
Message-ID: <3A8CB13D.ACE8A1@sympatico.ca>
Date: Thu, 15 Feb 2001 23:49:01 -0500
From: Chris Friesen <chris_friesen@sympatico.ca>
X-Mailer: Mozilla 4.74 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: calling all gurus!  odd and subtle network problem  -- followup, 
 possible answer
In-Reply-To: <3A8CA97F.EB514999@sympatico.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> The kicker is that the NIC with the MAC address in question happened to be in my
> G4 box running linux (yellowdog, 2.2.17 kernel).  It was a D-Link 530TX NIC, if
> it matters.  The linux box was not configured as a DHCP server or client, and
> both interfaces on the box were configured with static IP addresses.  The
> motherboard interface was eth0 and was set to an address on the corporate LAN.
> The other NIC was eth1 and was set to an address in the 192.168 range for
> testing.  The machine has been up and running in this configuration since
> september of last year with no known issues.  I made no changes at the time the
> problems started.

Okay, so some further digging revealed that someone was testing out the
"ethertap" device, which according to him requires ip_forwarding and proxy_arp
to be turned on.  I suspect this is what changed and caused the problems.  Since
rebooting cleaned up the /proc filesystem and reset these to zero, the problems
went away.

This feels like the answer to me.  It saw the arp requests coming in the one
interface, sent them out the other interface, and the other machines got
confused because they saw that arps coming from a different MAC address.

Guess this goes to show the problems people can get into with stuff they don't
understand....


Chris
