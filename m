Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbRHYP4A>; Sat, 25 Aug 2001 11:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269543AbRHYPzu>; Sat, 25 Aug 2001 11:55:50 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:62895 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S269481AbRHYPzp>;
	Sat, 25 Aug 2001 11:55:45 -0400
Date: Sat, 25 Aug 2001 17:55:45 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org
Subject: Re: Could NFS daemons be started via inetd?
Message-ID: <20010825175545.J773@cerebro.laendle>
Mail-Followup-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>,
	Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200108221341.IAA35277@tomcat.admin.navo.hpc.mil> <1209174562.20010825171357@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1209174562.20010825171357@port.imtp.ilyichevsk.odessa.ua>
X-Operating-System: Linux version 2.4.8-ac8 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2001 at 05:13:57PM +0300, VDA <VDA@port.imtp.ilyichevsk.odessa.ua> wrote:
> > Simple answer - no.
> > The reason it can't is in two parts:
> > 1. these daemons create their own socket rather than recieving one
> >    from inetd.

this is fine, other servers do that as well and work.

> > 2. The daemons must connect to rpcbind or portmap. Usually this daemon
> >    is not running at the time inetd is started.

this would be a bug in the initscripts, inetd is a rpc client so your
initscripts better make sure it is running (when neecsssary) before inetd.

> I have rpc.portmap started just before inetd in my init script.
> BTW, how portmapper

portmap often is too slow on startup. move it earlier in the ss sequence
or add a sleep 2 somewhere.

> > These daemons must run all the time or performance will be REALLY bad. Each
> > connection may request ~ 8K bytes of data.

just like othe rudp daemons they can linger, which works fine. also,
mountd does not need to be run all the time, it is very rarely used.

having said that, this is not kernel-related and shhould be taken
elsewhere. i managed to make (userspace) mountd run from inetd, but never
managed to get the nfsd working that way.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
