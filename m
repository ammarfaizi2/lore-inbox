Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUFBLnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUFBLnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 07:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUFBLnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 07:43:18 -0400
Received: from mail017.syd.optusnet.com.au ([211.29.132.168]:28068 "EHLO
	mail017.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261998AbUFBLnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 07:43:15 -0400
From: Con Kolivas <kernel@kolivas.org>
To: FabF <fabian.frederick@skynet.be>
Subject: Re: why swap at all?
Date: Wed, 2 Jun 2004 21:42:52 +1000
User-Agent: KMail/1.6.1
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
References: <E1BVIVG-0003wL-00@calista.eckenfels.6bone.ka-ip.net> <1086154721.2275.2.camel@localhost.localdomain>
In-Reply-To: <1086154721.2275.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406022142.52854.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004 15:38, FabF wrote:
> On Wed, 2004-06-02 at 01:17, Bernd Eckenfels wrote:
> > In article <200406012000.i51K0vor019011@turing-police.cc.vt.edu> you 
wrote:
> > > out (unlike some, I don't mind if Mozilla or OpenOffice end up out on
> > > disk after extended inactivity - but if my window manager gets swapped
> > > out, I get peeved when focus-follows-mouse doesn't and my typing goes
> > > into the wrong window or some such... ;)
> >
> > Yes but: your wm is so  often used/activated it will not get swaped  out.
> > But if your mouse passes over mozilla and tries to focus it, then you
> > will feel the pain of a swapped-out x program.
>
> Exactly !
> Does autoregulated VM swap. patch could help here ?

Unless you are pushing the limits of your available ram by your usage pattern 
then yes the autoregulated swappiness patch should help.

available here:
http://ck.kolivas.org/patches/2.6/2.6.7-rc2/patch-2.6.7-rc2-am11

Just a brief word that might clarify things for people. It seems this huge 
swap discussion centres around 2 different arguments. Akpm has said that the 
correct way for the vm to behave is that of swappiness=100. Desktop users 
note they have less swap out of the programs they use with swappiness 0 or 
their swap turned off. When your swappiness is set high, the current vm 
decisions are the fastest they can be, but when you go back to your 
applications they will take longer to restart. When your swappiness is set 
low your applications will restart rapidly, but the current vm will be doing 
more work and be slower. Most benchmarks will show the latter, but most 
desktop users will feel the former and not really notice the latter.

Try the little experiment to see: Boot with mem=128M and try to compile a 2.6 
kernel with all the debugging symbols option enabled - do this with 
swappiness set to 0 and then at 100. You'll see it compile much faster at 
100. Yet you know that if you set your swappiness to 0 mozilla will load 
faster next time you use it on your desktop during your normal usage pattern 
(of course you'd probably be using mozilla on a system with a bit more than 
128M ram but this helps demonstrate the point). 

Does this explain in coarse examples to the desktop users why ideal systems 
shouldn't be swap disabled or swappiness=0 ?

The autoregulated swappiness patch tries to get some sort of common ground, 
where it sacrifices performance slightly currently to improve what happens 
the next time you use your machine substantially. Because it changes with the 
amount of application pages in ram, it will not increasingly sacrifice 
performance when your memory is full with application pages. What it will not 
do is improve the swap thrash situation when you have grossly overloaded your 
ram.

Con
