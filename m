Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313997AbSDKGDi>; Thu, 11 Apr 2002 02:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313998AbSDKGDh>; Thu, 11 Apr 2002 02:03:37 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:10502 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313997AbSDKGDh>; Thu, 11 Apr 2002 02:03:37 -0400
Message-Id: <200204110600.g3B60UX08856@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Geoffrey Gallaway <geoffeg@sin.sloth.org>, linux-kernel@vger.kernel.org
Subject: Re: Update - Ramdisks and tmpfs problems
Date: Thu, 11 Apr 2002 09:03:43 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020409144639.A14678@sin.sloth.org> <20020410102343.A31552@sin.sloth.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 April 2002 12:23, Geoffrey Gallaway wrote:
> I finally found the problem, which appears to be a combination of things:
>
> Multiple tmpfs mounts and SMP.
>
> I am using a Dual Intel PIII 1Ghz box. When I use a SMP kernel AND do
> multiple tmpfs mounts (mount --bind /dev/shm/etc /etc; mount --bind
> /dev/shm/var /var) the machine goes into a reset loop. HOWEVER, when I use
> a non-SMP kernel and still do multiple tmpfs mounts OR when I use a SMP
> kernel and do only one tmpfs mount, the machine boots fine. Every once in a
> while (1 out of 20 times?) the machine would boot fine with a SMP kernel
> and multiple tmpfs mounts. Is this a timing issue?

Yes, sounds like race. It seems locking isn't quite right in tmpfs.

BTW, I'd like to know why do you want to use temporary storage
(tmpfs/shm/ramdisk) for /var and /etc? In 'normal' Unix (i.e. not a special
setup like computing farm) they are expected to survive reboot. Only /tmp
is volatile. You want to keep per-workstation config files (/etc) and data
(/var) across reboot, right?

Since my workstations aren't overstuffed with RAM, I use server supplied
storage for everything. If I will have a multigig RAM box someday, I'll
use tmpfs *only* for /tmp.
--
vda
