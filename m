Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271117AbTGWGP5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271120AbTGWGP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:15:56 -0400
Received: from soft.uni-linz.ac.at ([140.78.95.99]:13023 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S271117AbTGWGPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:15:51 -0400
Message-ID: <3F1E2B94.5010602@gibraltar.at>
Date: Wed, 23 Jul 2003 08:30:44 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-at, de-de, en-gb, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>,
       Jason Baron <jbaron@redhat.com>, vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4 and 2.4.22-pre7
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com>	 <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>	 <3F1D7C80.6020605@gibraltar.at>	 <1058904025.4160.30.camel@dhcp22.swansea.linux.org.uk>	 <3F1DB75E.1050906@kolumbus.fi> <1058917089.4768.6.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058917089.4768.6.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-07-22 at 23:14, Mika Penttilä wrote:
> 
>>/sbin/init used to start up with files->count > 1 and does 
>>close(0);close(1);close(2); -> kernel thread fds close.
>>
>>Now with unshare_files() and init's files->count ==1 the kernel threads  
>>/dev/console fds remain open. But one could ask of course so what :)
The problem with this behaviour is that the old root fs can not be 
unmounted in this case, which basically means that the machine will be 
unable to switch off its harddisk. And that, at least in my case, is 
annoying :)


> In other words the kernel side got caught out because it assumed 
> the bogus thread behaviour and needs some close() calls adding. That
> would make sense.
I have to admin that I don't really know the internals and thus don't 
completely understand. What would need to be done to fix it ? Change 
init's re-exec routines ?

best regards,
Rene

