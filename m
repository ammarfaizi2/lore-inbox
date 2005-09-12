Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVILLPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVILLPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVILLPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:15:21 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:48832 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750738AbVILLPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:15:20 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: DervishD <lkml@dervishd.net>
Subject: Re: Universal method to start a script at boot
Date: Mon, 12 Sep 2005 14:14:31 +0300
User-Agent: KMail/1.8.2
Cc: Michael Clark <michael@metaparadigm.com>, Brad Tilley <rtilley@vt.edu>,
       linux-kernel@vger.kernel.org
References: <1126462329.4324737923c2d@wmtest.cc.vt.edu> <200509121249.40467.vda@ilport.com.ua> <20050912110712.GA287@DervishD>
In-Reply-To: <20050912110712.GA287@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121414.31884.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 14:07, DervishD wrote:
>     Hi Denis :)
> 
>  * Denis Vlasenko <vda@ilport.com.ua> dixit:
> > Awful. This codifies ages-old Unix traditional SysV-like init
> > and its derivatives, which should be get rid of instead.
> 
>     I'm with you in this, in fact I use my own init system, but...
> 
> > daemontools are absolutely wonderful way of controlling daemons.
> 
>     How the heck you make sure that svscan starts the services in the
> correct order?

Simple. Usually I do not, because many of them do not
depend on each other. In cases where I must, I code it
in the script.

This is how do I wait for automount to start before
I mkswap/swapon on a windows nt swapfile:

echo -n "* Setting up swap"
i=9; while test "$i" -gt 0; do
    if test -d /mnt/auto/vfat.hda1; then
        echo
        mkswap /mnt/auto/vfat.hda1/PAGEFILE.SYS
        swapon /mnt/auto/vfat.hda1/PAGEFILE.SYS
        exit
    fi
    echo -n "."
    sleep 1
let i-=1; done
echo

Probably a small tool can make it look less ugly
(say, 'waitfor <seconds> <cmd> [<param>]'):

if waitfor 10 test -d /mnt/auto/vfat.hda1; then ...; fi

> > Does it run the services in /services in any 
> particular order or just in the order resulting for a simple
> globbing? How you make sure the services are shut down in any
> particular order?
> 
>     All this seems like requiring scripts to do the job (that is,
> ensuring a particular order of startup/shutdown), while sysvinit
> gets this info from filenames. Obviously, dictating the order using a
> script is far more flexible than using filenames but it's not as
> simple, and that cannot be seen in the comparisons D.J.B. does in the
> homepage of daemontools (which, BTW, is the only source of
> documentation, and a very poor one). LSB, on the other hand, is

djb is crazy genius, what did you expect ;)
There is GPLed replacement of daemontools at http://smarden.org/runit/

> better structured and although I don't like sysvinit at all, the
> system is better documented. And I hate runlevels...

me too.
--
vda
