Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbTCJRCC>; Mon, 10 Mar 2003 12:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbTCJRCC>; Mon, 10 Mar 2003 12:02:02 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:41733
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261224AbTCJRCA>; Mon, 10 Mar 2003 12:02:00 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DD9@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Adam J. Richter'" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: devfs + PCI serial card = no extra serial ports
Date: Mon, 10 Mar 2003 09:12:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 11:48 AM, Adam J. Richter wrote:
> [Sorry if this is a duplicate.  I sent it about 12 hours ago, 
> and it still
> has not appeared on marc.theaimsgroup.com or 
> www.uwsg.indiana.edu.-Adam]
> 
> On Fri, Mar 07, 2003, Theodore Ts'o wrote:
> >On Fri, Mar 07, 2003 at 02:51:45PM -0800, Bryan Whitehead wrote:
> >> It seems devfsd has an annoying "feature". I bought a PCI 
> card to get a 
> >> couple (2) more serial ports. The kernel doesn't seem to 
> set up the 
> >> serial ports at boot, so devfs never creates an entry. 
> However, post 
> >> boot, since there is no entries, I cannot configure the 
> serial ports 
> >> with setserial. So basically devfsd = no PCI based serial add on?
> >
> >Yep.  This I pointed this out as a flaw to devfs a long, long time
> >(years!) ago, but Richard chose not to listen to me.  Personally, I
> >solve this (and other) problems by simply refusing to use devfs.
> >
> >                                                - Ted
> 
>         Let me see if I understand the problem.  The sitution is
> that you have "stem cell" devices which initially are not defined
> to talk to a particular port, but which are then differentiated
> by a user level program doing ioctls to set the associated IO
> ports, interrupts and even UART types.  For example, exactly which
> kernel device is associated with which hardware device is controlled
> by user level software.
> 
>         There is nothing in devfs that prevents you from registering
> devfs devices even if they are not yet bound to specific hardware
> (you do not need a sysfs mapping, for example).  So, you should be
> able to register /dev/tts/0..N at initialization, where N is the
> maximum number of serial devices you want to support.
> 
>         Another approach, which I think provides a little more
> information to users, makes for a more readable /dev tree and should
> make some programs a few cycles faster would be to what my version of
> /dev/loop does (not the one currently in Linus's tree, alas): start by
> just creating /dev/tts/0, and then create /dev/tts/n+1 whenever
> /dev/tts/n is assigned and /dev/tts/n+1 has not already been defined.
> For /dev/loop, it was also useful to have the extra devices unregister
> when the highest number device became undefined (if a device in the
> middle were de-defined, it would not disappear until all higher
> numbered devices were also de-defined).
> 
>         Is this the issue, or do I misunderstand?
> 
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
Hi Adam,

The base issue on this one was that the card's PCI info was not in the 
table of known serial cards (serial_pci_tbl) in serial.c, so the serial 
driver did not detect and register it during system initialization.

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
