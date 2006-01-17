Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWAQTjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWAQTjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWAQTjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:39:13 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:11144 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S932418AbWAQTjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:39:12 -0500
Date: Tue, 17 Jan 2006 20:39:10 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IPMI BMC + MSI K1-1000S with tg3 and networking failure
Message-ID: <Pine.LNX.4.60.0601172006440.25680@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

does anyone here happen to have any experience with using the IPMI 1.5 BMC 
with Linux? I have a MSI K1-1000S server with Broadcom Tigon3 dual GLAN 
and a MS-9549 BMC server management card. I tried to enable the IPMI 
remote management functionality over the shared LAN. I've succeeded using 
the ipmitools, the remote managing works quite well.

But as I did this, the ordinary network communication in Linux stopped 
working. Some packets seem to flow both ways if I try to communicate, but 
nothing seems to happen. If I try simple ping from inside to outside, it 
does mostly nothing, from time to time I get about 2 or 3 responses in 
about 10 minute period, so that means that it is not completely dead, but 
somehow the packets are either mostly blocked by the BMC or worse, altered 
by the BMC. (If I read the IPMI 1.5 spec correctly, the BMC should be 
almost completely transparent to the remaining network packet stream.)
And when I try to access the server from outside, I get only to the BMC as 
expected, but when I try for instance the ssh access, I get a "Connection 
refused", though sshd is running properly.

No matter what configuration I try to set on the BMC, I cannot revert the 
behaviour. Before I managed to set the BMC configuration for the first 
time, everything worked as expected (without the remote server management 
functionality of course). Currently the only way I managed to make the 
ordinary Linux networking to work is to physically remove the BMC card 
(which of course results in no sensors, no fan control, etc.).

This leads me to a question. Isn't there some extra setting that the 
tg3 driver has to do to cooperate with the BMC to share the ethernet 
connection? (Perhaps the driver is not ready for such a cooperation?) Or 
is there some extra trick that I have to set on the BMC to make it work 
correctly with the other traffic?

Any suggestions or hints are very welcome, because currently the server is 
pretty much unusable. :(

Martin
