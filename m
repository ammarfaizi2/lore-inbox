Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbRHYOMd>; Sat, 25 Aug 2001 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269206AbRHYOMW>; Sat, 25 Aug 2001 10:12:22 -0400
Received: from [195.66.192.167] ([195.66.192.167]:38161 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S269186AbRHYOMM>; Sat, 25 Aug 2001 10:12:12 -0400
Date: Sat, 25 Aug 2001 17:13:57 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1209174562.20010825171357@port.imtp.ilyichevsk.odessa.ua>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: linux-kernel@vger.kernel.org
Subject: Re: Could NFS daemons be started via inetd?
In-Reply-To: <200108221341.IAA35277@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200108221341.IAA35277@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jesse,

Wednesday, August 22, 2001, 4:41:00 PM, you wrote:
>> I am setting up NFS on my Linux box.
>> When I start server daemons from init scripts or by hand,
>> everything is working fine.
>> 
>> I tried to arrange these daemons to be run by inetd
>> but after I issue an NFS mount command inetd starts spawning
>> tons on rpc.mountd daemons. Log is filled with:
>> ...
>> Does anybody tried this? If you do, I am very interested in your
>> inetd.conf and/or NFS part of startup script. Mine is:

> Simple answer - no.
> The reason it can't is in two parts:
> 1. these daemons create their own socket rather than recieving one
>    from inetd.

Please enlighten me: do daemons need to be writted with some support
code specific for inetd in order to be compatible with it?

> 2. The daemons must connect to rpcbind or portmap. Usually this daemon
>    is not running at the time inetd is started.

I have rpc.portmap started just before inetd in my init script.
BTW, how portmapper

> These daemons must run all the time or performance will be REALLY bad. Each
> connection may request ~ 8K bytes of data.

For now, my machine is under very light load (around 0.0) so this is
not a problem.
But I experiment a lot with different Linux toys
(NFS,Samba,TFTP,BOOTP/DHCP,PostgreSQL,MySQL). I'd like to configure it
so that under light load daemons die out, leaving bare minimum
(ideally, inetd only)

I presume daemons spawned by inetd are supposed to be designed so they
lurk around for some time in case some more requests are coming for them
and die after a timeout? Can they be made to spawn additional daemons when
load increases? This behavior would be nice - no need to guess how
many nfsd daemons to spawn for NFS, httpd's for HTTP etc.

Want to know why I'm asking all this?
Go to http://port.imtp.ilyichevsk.odessa.ua/vda/
-- 
Best regards,
VDA                            mailto:VDA@port.imtp.ilyichevsk.odessa.ua


