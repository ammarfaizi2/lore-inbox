Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSHYNi0>; Sun, 25 Aug 2002 09:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSHYNi0>; Sun, 25 Aug 2002 09:38:26 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:58585 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S317365AbSHYNiZ> convert rfc822-to-8bit; Sun, 25 Aug 2002 09:38:25 -0400
Date: Sun, 25 Aug 2002 15:42:28 +0200
Message-Id: <200208251342.g7PDgSX20335@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <joerg.beyer@email.de>
To: joerg.beyer@email.de, "MattiAarnio" <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org, "ZwaneMwaikambo" <zwane@linuxpower.ca>
Subject: Re: Re: big IRQ latencies, was:  <no subject>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio <matti.aarnio@zmailer.org> schrieb am 25.08.02 15:18:07:
> On Sun, Aug 25, 2002 at 02:38:59PM +0200, joerg.beyer@email.de wrote:
> > Zwane Mwaikambo <zwane@linuxpower.ca> schrieb am 25.08.02 14:10:12:
> > > On Sun, 25 Aug 2002 joerg.beyer@email.de wrote:
> > ...
> > > That should fix your slowdown during untarring/disk access, as for your 
> > > NIC problem looks like you might be having a receive FIFO overflow, so 
> > > perhaps the card stops processing incoming packets? I have no clue, 
> > 
> > maybe this helps: outgoing transfer (from the laptop to some
> > other machine) is reasonable fast: I could copy gig's of data
> > away, but not to the machine. I asume sending away makes not
> > so heavy use of IRQ's, right?
> 
> A laptop, you say ?   And network reception is jamming while

yes a laptop.

> there is high disk-write activity ?

nope - no other disk activity except the scp I used to
copy a file over the net. 
 
>   /sbin/hdparam -v /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)  <-----  ??
>  unmaskirq    =  1 (on)      <-----  ??
>  using_dma    =  1 (on)      <-----  ??
>  keepsettings =  1 (on)      <-----  ??
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
> 

I set the values as you suggested, but it made no difference:

joerg@laptop> scp othermachione:1gig_file /tmp

it take ~ 1/2 minute for 1 gig and gives a lot of errors
on the nic:

eth0      Protokoll:Ethernet  Hardware Adresse 00:07:CA:00:AC:A3  
          inet Adresse:10.0.0.30  Bcast:10.255.255.255  Maske:255.0.0.0
          UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:875 errors:6440 dropped:263 overruns:6440 frame:0
          TX packets:897 errors:0 dropped:0 overruns:0 carrier:0
          Kollisionen:0 Sendewarteschlangenlänge:100 
          RX bytes:1234333 (1.1 Mb)  TX bytes:79498 (77.6 Kb)
          Interrupt:10 Basisadresse:0xf000 

along with > 300 entries in /var/log/messages like this:

kernel: eth0: Too much work at interrupt, IntrStatus=0x0040

could anybody explain to me, why there is "Too much work at interrupt"?
and what I could do about it?

    Joerg

