Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTEOHhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTEOHhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:37:15 -0400
Received: from herculanum.int-evry.fr ([157.159.11.15]:6346 "EHLO
	herculanum.int-evry.fr") by vger.kernel.org with ESMTP
	id S263387AbTEOHhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:37:12 -0400
Message-ID: <3EC346A9.4010707@int-evry.fr>
Date: Thu, 15 May 2003 09:50:01 +0200
From: Yann COLLETTE <yann.collette@int-evry.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PLIP Problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the late answer.
Thanks for the tcpdump thing. I've tried it and I saw nothing on the link.
So I verified that the parallel port was correctly configured and ... it 
was (I was able to print things
on my printer).
No error/warning messages about plip.
So, I returned back to my computer shop and looked at what precisely had 
I bought:

A SERIAL null-modem ?

I thought null-modem was only dedicated to parallel port ?
So, I bought a PARALLEL null-modem and now it works fine (with kernel 
2.4.19).

Your sincerely,

Yann COLLETTE

Riley Williams wrote:

> Hi Yann.
>
> > I'm trying to connect a laptop to a my home computer using a PLIP
> > connection. On both computers, I've a Linux Mandrake 9.0 with a
> > kernel 2.4.20.
>
> I've never specifically used PLIP but there are some points to be
> cleared up in your email...
>
> > In /etc/hosts, I have pc.home.org 198.168.0.1 and laptop.home.org
> > 198.168.0.2
>
> Do you mean 192.168.0.1 and 192.168.0.2 respectively? The addresses
> you quote are valid across the Internet rather than being reserved
> for local LAN use.
>
> > For /etc/hosts.allow and /etc/hosts.deny, I've followed the
> > PLIP-HOWTO advices. I've configured the parport_pc module (for
> > both pc):
> >
> > insmod parport_pc io=0x378 irq=7
> >
> > The kernel messages are fine with this configuration.
> > Then I load the PLIP module (insmod plip).
>
> That looks fine so far...
>
> > On the laptop, I do:
> >
> > ifconfig plip0 laptop.home.org pointopoint pc.home.org \
> >        netmask 255.255.255.255 up
> > route add -host pc.home.org dev plip0
> >
> > And on my home computer I do:
> >
> > ifconfig plip0 pc.home.org pointopoint laptop.home.org netmask > 
> 255.255.255.255 up
> > route add -host laptop.home.org dev plip0
>
> I seem to remember that pointopoint implies netmask 255.255.255.255
> in which case the latter could be omitted.
>
> > On the laptop, when I ping the pc, nothing happens and on the pc,
> > when I ping the laptop, nothing happens too.
>
> Are your systems set up to respond to ping's ?
>
> As a better test of connectivity, run `tcpdump -i plip0` on one end,
> then run the ping on the other. That will show you whether there's
> any traffic going over the link. Swap them over and you'll check the
> other direction as well. Use CTRL-C to stop tcpdump.
>
> > I don't know where I am wrong:
>
> > - Maybe my parport is not really bidirectional on my laptop (how
> >   can I know if a parport can communicate ?)
>
> The above tcpdump test will show that.
>
> > - Maybe there's a problem with the way I configure the PLIP module
> >   (I don't known how to dive into the kernel sources to extract
> >   information about how to configure a module. There are no
> >   information about the PLIP module in the kernel documentation).
>
> Other things to check:
>
> * What type of parallel port do you have?
>
>   This is normally configured in the BIOS setup, from the following
>   options - the higher up this list, the better.
>
>           EPP 1.9
>           EPP 1.7
>           EPP/ECP
>           ECP/EPP
>           ECP
>           Normal
>
> * Is your cable wired correctly? Depending on the type of parallel
>   port, you need one of two different sets of wiring - either the
>   "Standard LapLink" or the "Wide LapLink" cable.
>
>   The tcpdump test above will answer this question. Simply put, if
>   there is traffic passing both ways then the cable is correct.
>
> * Do you have a firewall set up on either system? If so, disable it
>   and see if that fixes the problem.
>
> Personally, I was stung by the last item recently, and that's with a
> standard Ethernet link where there's less to go wrong to start with.
>
> Best wishes from Riley.
> ---
> * Nothing as pretty as a smile, nothing as ugly as a frown.
>
> ---
> Outgoing mail is certified Virus Free.
> Checked by AVG anti-virus system (http://www.grisoft.com).
> Version: 6.0.476 / Virus Database: 273 - Release Date: 24-Apr-2003
>
>
>  
>



