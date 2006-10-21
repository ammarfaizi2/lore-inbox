Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992810AbWJUDOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992810AbWJUDOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 23:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992812AbWJUDOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 23:14:31 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:15409 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S2992810AbWJUDOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 23:14:31 -0400
Date: Fri, 20 Oct 2006 21:14:27 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: 2.6.19-rc2 ipw2200 breakage with wpa_supplicant
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: yi.zhu@intel.com, jketreno@linux.intel.com
Message-id: <45399093.6090306@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something changed between 2.6.18-mm1 and 2.6.19-rc2 to cause my laptop's 
ipw2200 to be unable to associate with the access point using 
NetworkManager and wpa_supplicant. I keep seeing this kind of thing over 
and over in the wpa_supplicant output:

Trying to associate with (removed) (SSID='Robman' freq=0 MHz)
CTRL_IFACE monitor send - hexdump(len=43): (removed)
Cancelling scan request
WPA: clearing own WPA/RSN IE
Automatic auth_alg selection: 0x1
RSN: using IEEE 802.11i/D9.0
WPA: Selected cipher suites: group 16 pairwise 16 key_mgmt 2
WPA: clearing AP WPA IE
WPA: set AP RSN IE - hexdump(len=22): (removed)
WPA: using GTK CCMP
WPA: using PTK CCMP
WPA: using KEY_MGMT WPA-PSK
WPA: Set own WPA IE default - hexdump(len=22):(removed)
p key clearing
er_wext_set_drop_unencrypted
State: ASSOCIATING -> ASSOCIATING
wpa_driver_wext_associate
Setting authentication timeout: 15 sec 0 usec
EAPOL: External notification - EAP success=0
EAPOL: External notification - EAP fail=0
EAPOL: External notification - portControl=Auto
RSN: Ignored PMKID candidate without preauth flag
Wireless event: cmd=0x8b06 len=8
Wireless event: cmd=0x8b1a len=15
Wireless event: cmd=0x8b19 len=8
Received 1373 bytes of scan results (6 BSSes)
Scan results: 6
Selecting BSS from priority group 0
0: (removed) ssid='Robman' wpa_ie_len=0 rsn_ie_len=22 caps=0x11
    selected based on RSN IE
Trying to associate with (removed) (SSID='Robman' freq=0 MHz)

and iwevent keeps showing this repeatedly:

20:52:32.303911   eth1     Scan request completed
20:52:32.303945   eth1     Set Mode:Managed
20:52:32.303962   eth1     Set ESSID:"Robman"
20:52:32.671509   eth1     Scan request completed
20:52:32.671542   eth1     Set Mode:Managed
20:52:32.671560   eth1     Set ESSID:"Robman"
20:52:33.034063   eth1     Scan request completed

Replacing ipw2200.c from 2.6.18-mm1 (adapted for the irq changes) fixes 
the problem.

I do notice that I keep seeing those "Scan request completed" messages 
from iwevent when nothing is going on with the 2.6.19-rc2 driver but not 
the 2.6.18-mm1 driver.

Anyone else seeing this?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
