Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSGRHTP>; Thu, 18 Jul 2002 03:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGRHTP>; Thu, 18 Jul 2002 03:19:15 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:7892 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S316599AbSGRHTO>; Thu, 18 Jul 2002 03:19:14 -0400
Date: Thu, 18 Jul 2002 10:21:56 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: "J. Hart" <jhart@atr.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File Corruption in Kernel 2.4.18
Message-ID: <20020718072155.GB1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"J. Hart" <jhart@atr.co.jp>, linux-kernel@vger.kernel.org
References: <3D362125.3A324489@atr.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D362125.3A324489@atr.co.jp>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:00:05AM +0900, you [J. Hart] wrote:
> 
>      A few of the files at the copy destination, typically three or four, will
> usually be corrupt while the source files will be correct.  Occasionally the
> copy will be done without any corrupt files at the destination.  The
> mem=nopentium option appears to have no effect on this.  An overnight test using
> the memtest86 utility shows no memory errors.  The corruption in each file
> occurs in precise 4096 byte blocks.  An overnight test using the memtest86
> utility shows no memory errors.  The corruption in each file occurs in precise
> 4096 byte blocks.  

> motherboard   : ASYS-A7V

Asus A7V is Via KT133 based, right? It has additional Promise ide
controller?

> Linux version : Slackware 8
> Kernel        : 2.4.18

Stock 2.4.18, no patches? Which filesystem are you using? Ext2, ext3, other?

> hard disk     : ATA100 IBM-DTLA-307045 45gb
> hd controller : Promise Technology, Inc. 20265

So the harddisk is connected to Promise, not Via? You have no other
harddisks?

> cpu           : 900mhz AMD Athlon

I had enormous trouble with a KT133(A or not) based mobo (Abit-KT7(A)-RAID
in past - it would just corrupt data when transferring big files from the
additional ide controller (HPT370 in this case). The Via ide controller
didn't show this behaviour.

- This happened on 2.2.20, 2.4.15, 2.4.18preX + ide-patch.
- Memtest86 showed nothing
- Network activity seemed to have to do with it
- Changing the NIC to another PCI slot and tweaking bios params seemed to
  help, but eventually it happened again
- I eventually concluded that KT133 corrupts PCI transfers under load, which
  was found out by others in 'net as well. 
- Tried bios updates and contacting Via, Highpoint, Abit. Highpoint and Abit
  never cared to answer. Neither did Via until I spotted an Via employee on
  viahardware.com forum. She said they'd investigate the issue, never heard
  of her since.
- Ditched the mobo fo good, bought an Abit ST6R, and never had a problem
  since. You may be lucky just switching the drive to Via ide.

First reports on the corruption:

http://marc.theaimsgroup.com/?l=linux-kernel&m=100651892331843&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=100669782329815&w=2
http://groups.google.com/groups?q=We+first+reported+disk+corruption+with+a+VIA+KT133A+based+board&hl=en&lr=&ie=UTF-8&oe=utf-8&selm=linux.kernel.00c201c1a033%241cf46700%24b71c64c2%40viasys.com&rnum=3

There was a long thread on forums.viahardware.com as well
(http://forums.viaarena.com/messageview.cfm?catid=6&threadid=7171&start=21),
but it seems they have sensored it away for good.

I've also received reports of similar experiences from a number of people
since I wrote to linux-kernel about this.

I repoduced the problem with wrchk utility I wrote
(http://iki.fi/v/tmp/wrchk.c) but it seems you can do it with you directory
tree copying.


-- v --

v@iki.fi
