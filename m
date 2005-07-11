Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVGKWaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVGKWaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVGKW17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:27:59 -0400
Received: from rimuhosting.com ([69.90.33.248]:49847 "EHLO rimuhosting.com")
	by vger.kernel.org with ESMTP id S262962AbVGKW1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:27:00 -0400
Message-ID: <42D2F22C.3060102@rimuhosting.com>
Date: Tue, 12 Jul 2005 10:26:52 +1200
From: Peter <peter.spamcatcher@rimuhosting.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: unregister_netdevice: waiting for tap24 to become free
References: <20050709110143.D59181E9EA4@zion.home.lan> <20050709120703.C2175@flint.arm.linux.org.uk> <42D2C487.60302@rimuhosting.com> <200507120020.52418.blaisorblade@yahoo.it>
In-Reply-To: <200507120020.52418.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in the logs prior to the first error message.

I've hit this before at different times on other servers.  If there are 
some commands I can run to gather more diagnostics on the problem, 
please let me know and I'll capture more information next time.

I see the error was reported with older 2.6 kernels and a patch was 
floating around.  I'm not sure if that is integrated into the current 
2.6.11 kernel. 
http://www.google.com/search?q=unregister_netdevice%3A+waiting

Regards, Peter

Jul 10 16:52:03 host39 sshd(pam_unix)[19779]: authentication failure; 
logname= uid=0 euid=0 tty=ssh ruser= rhost=140.123.23.77  user=halt
Jul 10 16:52:07 host39 sshd(pam_unix)[19781]: check pass; user unknown
Jul 10 16:52:07 host39 sshd(pam_unix)[19781]: authentication failure; 
logname= uid=0 euid=0 tty=ssh ruser= rhost=140.123.23.77
Jul 11 12:04:04 host39 kernel: unregister_netdevice: waiting for tap24 
to become free. Usage count = 1


Blaisorblade wrote:
> On Monday 11 July 2005 21:12, Peter wrote:
> 
>>Hi.  I am hitting a bug that manifests in an unregister_netdevice error
>>message.  After the problem is triggered processes like ifconfig, tunctl
>>and route refuse to exit, even with killed.
> 
> Even from the "D" state below, it's clear that there was a deadlock on some 
> semaphore, related to tap24... Could you search your kernel logs for traces 
> of an Oops?
> 
>>And the only solution I 
>>have found to regaining control of the server is issuing a reboot.
> 
> 
>>The server is running a number of tap devices.  (It is a UML host server
>>running the skas patches http://www.user-mode-linux.org/~blaisorblade/).
>>
>>Regards, Peter
>>
>># uname -r
>>2.6.11.7-skas3-v8
>>
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>>
>>
>>30684 ?        DW     0:45          \_ [tunctl]
>>31974 ?        S      0:00 /bin/bash ./monitorbw.sh
>>31976 ?        S      0:00  \_ /bin/bash ./monitorbw.sh
>>31978 ?        D      0:00      \_ /sbin/ifconfig
>>31979 ?        S      0:00      \_ grep \(tap\)\|\(RX bytes\)
>>32052 ?        S      0:00 /bin/bash /opt/uml/umlcontrol.sh start --user
>>gildersleeve.de
>>32112 ?        S      0:00  \_ /bin/bash /opt/uml/umlrun.sh --user
>>gildersleeve.de
>>32152 ?        S      0:00      \_ /bin/bash ./umlnetworksetup.sh
>>--check --user gildersleeve.de
>>32176 ?        D      0:00          \_ tunctl -u gildersleeve.de -t tap24
>>
