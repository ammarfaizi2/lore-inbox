Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVGKWS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVGKWS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVGKWPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:15:49 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:64677 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262700AbVGKWNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:13:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ROxvKNnbn/+XEcqRBCRLG6G7T/zaMBfxkllz2VKrFflvREohDA8Nisx1ey9TcTcASvXh8oafLR1+zhpFXtW5fAQBgZ25/hbBXFUQ+wemkHXzK2VNI2Pdm3RTWfMrKWif3kFjTM3Hxxvct7myQXiChKYuZBUOfC6JFdjOSFqDLZA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] unregister_netdevice: waiting for tap24 to become free
Date: Tue, 12 Jul 2005 00:20:52 +0200
User-Agent: KMail/1.8.1
Cc: Peter <peter.spamcatcher@rimuhosting.com>, linux-kernel@vger.kernel.org
References: <20050709110143.D59181E9EA4@zion.home.lan> <20050709120703.C2175@flint.arm.linux.org.uk> <42D2C487.60302@rimuhosting.com>
In-Reply-To: <42D2C487.60302@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507120020.52418.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 July 2005 21:12, Peter wrote:
> Hi.  I am hitting a bug that manifests in an unregister_netdevice error
> message.  After the problem is triggered processes like ifconfig, tunctl
> and route refuse to exit, even with killed.
Even from the "D" state below, it's clear that there was a deadlock on some 
semaphore, related to tap24... Could you search your kernel logs for traces 
of an Oops?
> And the only solution I 
> have found to regaining control of the server is issuing a reboot.

> The server is running a number of tap devices.  (It is a UML host server
> running the skas patches http://www.user-mode-linux.org/~blaisorblade/).
>
> Regards, Peter
>
> # uname -r
> 2.6.11.7-skas3-v8
>
> unregister_netdevice: waiting for tap24 to become free. Usage count = 1
> unregister_netdevice: waiting for tap24 to become free. Usage count = 1
> unregister_netdevice: waiting for tap24 to become free. Usage count = 1
> unregister_netdevice: waiting for tap24 to become free. Usage count = 1
> unregister_netdevice: waiting for tap24 to become free. Usage count = 1
> unregister_netdevice: waiting for tap24 to become free. Usage count = 1
> unregister_netdevice: waiting for tap24 to become free. Usage count = 1
>
>
> 30684 ?        DW     0:45          \_ [tunctl]
> 31974 ?        S      0:00 /bin/bash ./monitorbw.sh
> 31976 ?        S      0:00  \_ /bin/bash ./monitorbw.sh
> 31978 ?        D      0:00      \_ /sbin/ifconfig
> 31979 ?        S      0:00      \_ grep \(tap\)\|\(RX bytes\)
> 32052 ?        S      0:00 /bin/bash /opt/uml/umlcontrol.sh start --user
> gildersleeve.de
> 32112 ?        S      0:00  \_ /bin/bash /opt/uml/umlrun.sh --user
> gildersleeve.de
> 32152 ?        S      0:00      \_ /bin/bash ./umlnetworksetup.sh
> --check --user gildersleeve.de
> 32176 ?        D      0:00          \_ tunctl -u gildersleeve.de -t tap24
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by the 'Do More With Dual!' webinar
> happening July 14 at 8am PDT/11am EDT. We invite you to explore the latest
> in dual core and dual graphics technology at this free one hour event
> hosted by HP, AMD, and NVIDIA.  To register visit
> http://www.hp.com/go/dualwebinar
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.beta.messenger.yahoo.com
