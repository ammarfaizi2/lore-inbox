Return-Path: <linux-kernel-owner+w=401wt.eu-S932694AbXAJDWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbXAJDWP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 22:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbXAJDWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 22:22:15 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:55995 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932694AbXAJDWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 22:22:14 -0500
Date: Wed, 10 Jan 2007 04:12:44 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jeb Cramer <cramerj@intel.com>, John Ronciak <john.ronciak@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
Message-ID: <20070110021244.GF3803@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jeb Cramer <cramerj@intel.com>,
	John Ronciak <john.ronciak@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>
References: <20070109222708.GA15510@m.safari.iki.fi> <45A42C62.2030309@intel.com> <20070110011019.GD3803@m.safari.iki.fi> <45A445D4.8090206@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A445D4.8090206@intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 17:48:04 -0800, Auke Kok wrote:
> Sami Farin wrote:
> >On Tue, Jan 09, 2007 at 15:59:30 -0800, Auke Kok wrote:
> >>Sami Farin wrote:
> >...
> >>>I do "ethtool -K eth0 tso off" now and check if I get the hang again. =)
> >>I'm unsure whether v7.2.x already automatically disables TSO for 100mbit 
> >>speed link, probably not. It should.
> >
> >It disabled it but I enabled it just for fun.
> > 
> >>Please try our updated driver from http://e1000.sf.net/ (7.3.20) against 
> >>the same kernel. There are some changes with regard to the ich8/TSO 
> >>driver that might affect this, so re-testing is worth it for us.
> >
> >I now run 7.3.20-NAPI.
> >
> >BTW. the Makefile is buggy: it does not get CC from kernel's Makefile.
> >Using wrong compiler can cause for example a reboot when loading the 
> >module.
> >(At least that's what happened with gcc-2.95.3 vs 3.x.x some years ago...)
> 
> I'll look into that, do you have any suggestions?

loop-AES has some hacks which figure out the correct CC
http://heanet.dl.sourceforge.net/sourceforge/loop-aes/loop-AES-v3.1e.tar.bz2

> >>also, please always include the full dmesg output. Feel free to CC 
> >>e1000-devel@lists.sourceforge.net on this.
> >
> >I enabled TSO again.  I write again if TSO causes problems.
> 
> There are known problems with that configuration, that's why the newer 
> drivers disable TSO for 10/100 speeds.
> 
> do you really think that you can see the performance gain fro musing TSO at 

No.

I was thinking that if TSO does not work at 100, why 1000 would be
any better.  But I can't test at 1000 speeds right now.

But if you say driver is supposed to hang at 100 speed,
I believe you.

Ohh... that was fast.

2007-01-10 04:07:42.303056500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
2007-01-10 04:07:42.303081500 <4>  Tx Queue             <0>
2007-01-10 04:07:42.303082500 <4>  TDH                  <48>
2007-01-10 04:07:42.303083500 <4>  TDT                  <fa>
2007-01-10 04:07:42.303084500 <4>  next_to_use          <fa>
2007-01-10 04:07:42.303085500 <4>  next_to_clean        <48>
2007-01-10 04:07:42.303086500 <4>buffer_info[next_to_clean]
2007-01-10 04:07:42.303087500 <4>  time_stamp           <9e332d8>
2007-01-10 04:07:42.303088500 <4>  next_to_watch        <49>
2007-01-10 04:07:42.303088500 <4>  jiffies              <9e336df>
2007-01-10 04:07:42.303094500 <4>  next_to_watch.status <0>
2007-01-10 04:07:43.302826500 <3>e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
2007-01-10 04:07:43.302850500 <4>  Tx Queue             <0>
2007-01-10 04:07:43.302851500 <4>  TDH                  <48>
2007-01-10 04:07:43.302852500 <4>  TDT                  <34>
2007-01-10 04:07:43.302853500 <4>  next_to_use          <34>
2007-01-10 04:07:43.302854500 <4>  next_to_clean        <48>
2007-01-10 04:07:43.302855500 <4>buffer_info[next_to_clean]
2007-01-10 04:07:43.302855500 <4>  time_stamp           <9e332d8>
2007-01-10 04:07:43.302856500 <4>  next_to_watch        <49>
2007-01-10 04:07:43.302857500 <4>  jiffies              <9e33ac7>
2007-01-10 04:07:43.302862500 <4>  next_to_watch.status <0>
...

> those speeds anyway? we don't ;). In any case you should keep TSO off for 
> 10/100 speeds.

...
> >PS. please do not delete Mail-Followup-To header field.
> 
> I hit "reply-all" and I have no control over which field thunderbird 

I hit list-reply.

> removes or adds. I have to manually add your e-mail address too?

No.

> Maybe your mail client is broken instead?

No.  

> Don't you want to receive replies?

Yes.

I am subscribed to the mailing list.
That's why my email was not in Mail-Followup-To.

But if your thunderbird does not support Mail-Followup-To,
just ignore it.  I can add the header field manually.

-- 
