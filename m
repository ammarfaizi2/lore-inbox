Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTAWNVT>; Thu, 23 Jan 2003 08:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbTAWNVT>; Thu, 23 Jan 2003 08:21:19 -0500
Received: from core-172-210.merlin.at ([212.60.172.210]:52985 "EHLO
	office.webcluster.prv") by vger.kernel.org with ESMTP
	id <S265211AbTAWNVR>; Thu, 23 Jan 2003 08:21:17 -0500
Reply-To: <dk@webcluster.at>
From: "Daniel Khan" <dk@webcluster.at>
To: <linux-kernel@vger.kernel.org>
Subject: Ferquently system lockups under load
Date: Thu, 23 Jan 2003 14:30:27 +0100
Message-ID: <CGEAIHJJGFFOPODELPILOEIHDKAA.dk@webcluster.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

this posting is the last try to get a solution for a problem I have since
summer last year.

Last summer we bought 2 servers for a cluster and run RedHat 7.2 on it.
We had frequently lockups (I will describe later) and decided to exchange
the hole
hardware. On the 2 new servers we installed RedHat 7.3 and the same problems
occured.
We always had the latest RedHat SMP kernels _now_ we are on
2.4.18-19.7.xsmp.

The lockup:
Mostly under higher load (cronjobs) the problem happens
If the problem occurs the remote shell is dropped. Also the local shell
doesn't accept any
commands.
All ports remain open.
All interfaces remain up.
A telnet to ports like pop3 result in a "connected" message but nothing
more.
Only courier IMAP gives a "Hello" message but this is all.
So there are no services reachable anymore.
The only solution is a hard reset.
There are no logfile entries that indicate any problem.
Seems as if syslog also crashes before.

The system:
glibc-2.2.5-42
heartbeat-0.4.9f-1
RedHat 7.3 2.4.18-19.7.xsmp
pam_ldap
nss_ldap-198-3
openldap-2.0.25-1

all 7 partitions ext3 with default params in an IDE hardware raid 5:
/dev/hda2              26G  5.4G   19G  22% /
/dev/hda1              45M   42M  2.1M  96% /boot
/dev/hda3              65G   12G   50G  19% /home
none                  756M     0  755M   0% /dev/shm
/dev/hda9             243M  4.8M  225M   3% /tmp
/dev/hda5              24G  159M   22G   1% /var/lib/mysql
/dev/hda6              20G  3.1G   16G  17% /var/log/httpd
/dev/hda7              13G   33M   12G   1% /var/spool/mail

The hardware:
IDE Raid controller: ACCUSYS ACS7610 B0W121 (on the first servers it was a
3ware)
2x 1.2 GHZ CPU's
1Gb Ram

What I found out:
As long as I don't do LDAP lookups in postfix the system seems to be stable

Other things:
I don't use nscd.
I have updated all packages (At least RedHat network tells me that
everything's fine.)

Why I think it's a kernel issue:
Well it may also be a problem in nss_ldap but I think that everything goes
back to the kernel
if the system get's locked down totally.
I am now thinking that it may be a problem in ext3 in conjunction with
nss_ldap.
But - as you allready found out I'm no kernel hacker at all. I am simply
trying to debug
and rule out since month's and now I'm really stuck.

I would be glad if somebody could help me on this problem or point me into
the right direction
cause the only thing I can search for is "RedHat crash","RedHat
freeze","RedHat ext3 crash"
as I simply don't know why and how this happens...

Would you please CC the message to me as I am not subscribed yet and please
don't shoot at me...

Thanks in advance - _AND_ thanks for your work on the linux kernel.

--
Daniel Khan

