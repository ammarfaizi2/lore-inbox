Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270462AbTHGSlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270471AbTHGSlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:41:11 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:37849 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S270462AbTHGSlH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:41:07 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Paul Clements <Paul.Clements@steeleye.com>
Subject: Re: [2.4.21]: nbd ksymoops-report
Date: Thu, 7 Aug 2003 20:40:58 +0200
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.10.10308071245130.13289-100000@clements.sc.steeleye.com> <3F328DB9.4EF38D9A@SteelEye.com>
In-Reply-To: <3F328DB9.4EF38D9A@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308072040.58144.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Yes we are using the nbd-client from sf.net (due to other problems we replaced 
the debian (non-standard) sf.net binary with our own compiled binary).

On Thursday 07 August 2003 19:34, you wrote:
> Paul Clements wrote:
> > On Thu, 7 Aug 2003, Bernd Schubert wrote:
> > > every time when nbd-client disconnects a nbd-device the decoded oops
> > > from below will happen.
> > > This only happens after we upgraded from 2.4.20 to 2.4.21,
> > > so I guess the backported update from 2.5.50 causes this.
>
> [snip]
>
> > This corresponds to the following source:
> >
> > lo->sock->ops->shutdown(lo->sock, SEND_SHUTDOWN|RCV_SHUTDOWN);
> >
> > Somehow, lo->sock is NULL here. The only way I see that this could
>
> Alright, looking back over the nbd-client source I now see what's going
> on. You're calling "nbd-client -d" to manually disconnect?

The debian /etc/init.d/nbd-client script calls this on stopping stopping nbd. 
To make nbd working again after this oops we always need to reboot now (found 
this out after my first mail), so I'm really looking for an alternative way 
of stopping nbd. Would 'killall nbd-client' work?

>
> > Would you be willing to test a patch against 2.4.21?
>
> If you're willing to test the attached patch, I'd be grateful. Otherwise
> I'll test it in the next few days and forward on to Marcelo...

I will first test it at home. Unfortunality my laptop is in repair at IBM, so 
I only can use nbd via localhost.
If there is a way to prevent the reboot of the client, I can test it on monday 
on our cluster at work. 

Thanks a lot for your very fast help. Since we are using nbd to have a 
fallback server of our main server, we really need a working solution.


Thanks again and best regards,
	Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
