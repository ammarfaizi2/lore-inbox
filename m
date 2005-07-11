Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVGKTMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVGKTMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVGKTM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:12:27 -0400
Received: from rimuhosting.com ([69.90.33.248]:42165 "EHLO rimuhosting.com")
	by vger.kernel.org with ESMTP id S262257AbVGKTMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:12:19 -0400
Message-ID: <42D2C487.60302@rimuhosting.com>
Date: Tue, 12 Jul 2005 07:12:07 +1200
From: Peter <peter.spamcatcher@rimuhosting.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: user-mode-linux-devel@lists.sourceforge.net
Subject: unregister_netdevice: waiting for tap24 to become free
References: <20050709110143.D59181E9EA4@zion.home.lan> <20050709120703.C2175@flint.arm.linux.org.uk>
In-Reply-To: <20050709120703.C2175@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I am hitting a bug that manifests in an unregister_netdevice error 
message.  After the problem is triggered processes like ifconfig, tunctl 
and route refuse to exit, even with killed.  And the only solution I 
have found to regaining control of the server is issuing a reboot.

The server is running a number of tap devices.  (It is a UML host server 
running the skas patches http://www.user-mode-linux.org/~blaisorblade/).

Regards, Peter

# uname -r
2.6.11.7-skas3-v8

unregister_netdevice: waiting for tap24 to become free. Usage count = 1
unregister_netdevice: waiting for tap24 to become free. Usage count = 1
unregister_netdevice: waiting for tap24 to become free. Usage count = 1
unregister_netdevice: waiting for tap24 to become free. Usage count = 1
unregister_netdevice: waiting for tap24 to become free. Usage count = 1
unregister_netdevice: waiting for tap24 to become free. Usage count = 1
unregister_netdevice: waiting for tap24 to become free. Usage count = 1


30684 ?        DW     0:45          \_ [tunctl]
31974 ?        S      0:00 /bin/bash ./monitorbw.sh
31976 ?        S      0:00  \_ /bin/bash ./monitorbw.sh
31978 ?        D      0:00      \_ /sbin/ifconfig
31979 ?        S      0:00      \_ grep \(tap\)\|\(RX bytes\)
32052 ?        S      0:00 /bin/bash /opt/uml/umlcontrol.sh start --user 
gildersleeve.de
32112 ?        S      0:00  \_ /bin/bash /opt/uml/umlrun.sh --user 
gildersleeve.de
32152 ?        S      0:00      \_ /bin/bash ./umlnetworksetup.sh 
--check --user gildersleeve.de
32176 ?        D      0:00          \_ tunctl -u gildersleeve.de -t tap24
