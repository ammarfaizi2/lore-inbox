Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSGAH6A>; Mon, 1 Jul 2002 03:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSGAH57>; Mon, 1 Jul 2002 03:57:59 -0400
Received: from esperi.demon.co.uk ([194.222.138.8]:49933 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S315449AbSGAH55>; Mon, 1 Jul 2002 03:57:57 -0400
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 (and maybe earlier versions) can't see my IDE disks where 2.2 can
References: <871yao7erp.fsf@amaterasu.srvr.nix>
	<200207010657.g616voT17255@Port.imtp.ilyichevsk.odessa.ua>
X-Emacs: more boundary conditions than the Middle East.
From: Nix <nix@esperi.demon.co.uk>
Date: 01 Jul 2002 08:43:03 +0100
In-Reply-To: <200207010657.g616voT17255@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <87ofdrsxko.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Economic Science)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Denis Vlasenko said:
> On 30 June 2002 17:22, Nix wrote:
>> I'm using a ten year old 486 as a firewall, with an aged transparent
>> 2.5Mb Promise caching IDE controller managing a couple of fairly
>> bog-standard IDE disks (one a 420Mb 1989-vintage Western Digital of some
>> kind, the other a 1994-vintage 1Gb IBM disk). I can't find out the model
>> numbers without taking the machine to pieces, because even with 2.2.20
>> the (new) ide driver says
[snip --- probe fails to pick up any drives in 2.4, 2.2 says `non-IDE disk'
 but then works OK: if detection is forced with kernel parameters, 2.4 says
`hda6: bad access: block=2, count=2'... old hd.c driver works, but...]

> If 2.4 kernel does not work:
> Andre Hedrick <andre@linux-ide.org> [09 apr 2002]

[so copied: Andre, the earlier post is at
 <http://www.uwsg.iu.edu/hypermail/linux/kernel/0206.3/0679.html>.]

> Include lspci data and .config

lspci? On a 486 that's considerably older than the PCI spec itself? It's
ISA here, as far as the eye can see... as for ATA/ATAPI, forget it :)

One of the problems I'm having is that without PCI info, with a box
that's old enough that I can't easily tell what the hard drive models
actually *are*, it's hard to know where to start debugging :) I may have
to pull it apart and see if the drives have identifying labels on them.

I think that one of the problem spots may be that do_probe() spends most
of its time trying to fire ATA commands at the drive: I don't expect the
drives in *this* machine to make head or tail of that.

Anyway, I'm going to start a cautious forward merge of the 2.2 ide-probe
code into 2.4, and see when the behaviour changes. (Cautious and *slow*,
because this box is a firewall that has to be running most of the
time, so I'll have to sneak debugging in at odd hours. :( )

-- 
`What happened?'
                 `Nick shipped buggy code!'
                                             `Oh, no dinner for him...'
