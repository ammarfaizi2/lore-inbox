Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSIEKfK>; Thu, 5 Sep 2002 06:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSIEKfK>; Thu, 5 Sep 2002 06:35:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3032 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317396AbSIEKfJ>;
	Thu, 5 Sep 2002 06:35:09 -0400
Message-Id: <200209051038.g85AchSU184432@westrelay01.boulder.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Suparna Bhattacharya" <suparna@in.ibm.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, yakker@alcritech.com
Subject: Re: writing OOPS/panic info to nvram?
Date: Thu, 05 Sep 2002 16:08:49 +0530
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl> <20020904140856.GA1949@werewolf.able.es> <1031149539.2788.120.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2002 20:02:40 +0530, Alan Cox wrote:

> On Wed, 2002-09-04 at 15:08, J.A. Magallon wrote:
>> Instead of swap, let user specify a partition to raw dump there. If a
>> user wants crash dumps, he has to leave some small disk space free and
>> give an option like "dump=/dev/hda7".
> 
> With what will you write it - not the linux block layer thats for sure.
> Ingo has patches for doing network dumps which are kind of neat
> 
> -


LKCD for 2.5 (WIP) has a dump driver interface through which different 
target types can be plugged in. For example Ingo's polled network dump 
code been integrated as one such dump driver target (generic type),
block layer based i/o is available as another target (for those
who chose to use it for their raw partition).Down the line specific
dump drivers suited for the hardware concerned, e.g Rusty's polled
IDE driver, could be plugged in as dump target too, as could NECs
work on converting dump block i/o to polled mode. 

Conceivably, one may perhaps have alternate targets available on the 
same system and failover to the suitable one based on the situation.
(If the network interface code is the one in trouble, try to
dump to the dedicated raw disk or vice versa).

And then, a little later there could be the option of memory save 
option abstracted as another driver target, to be followed 
by a soft-reboot (w/o clearing memory) for performing actual dump i/o
to persistent storage on architectures where this option works out.

Regards
Suparna
