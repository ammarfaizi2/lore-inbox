Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUG2Jqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUG2Jqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267379AbUG2Jqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:46:30 -0400
Received: from www.logi-track.com ([213.239.193.212]:53910 "EHLO
	mail.logi-track.com") by vger.kernel.org with ESMTP id S267424AbUG2JqG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:46:06 -0400
Date: Thu, 29 Jul 2004 11:46:02 +0200
From: Markus Schaber <schabios@logi-track.com>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The dreadful CLOSE_WAIT
Message-Id: <20040729114602.052c9506@kingfisher.intern.logi-track.com>
In-Reply-To: <20040728144723.GA32602@DervishD>
References: <20040727083947.GB31766@DervishD>
	<4106869A.5030905@sun.com>
	<20040727170907.GA26136@DervishD>
	<20040728140622.2bc69fa5@kingfisher.intern.logi-track.com>
	<20040728144723.GA32602@DervishD>
Organization: logi-track ag, =?ISO-8859-15?Q?z=FCrich?=
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: Nx5T&>Nj$VrVPv}sC3IL&)TqHHOKCz/|)R$i"*r@w0{*I6w;UNU_hdl1J4NI_m{IMztq=>cmM}1gCLbAF+9\#CGkG8}Y{x%SuQ>1#t:;Z(|\qdd[i]HStki~#w1$TPF}:0w-7"S\Ev|_a$K<GcL?@F\BY,ut6tC0P<$eV&ypzvlZ~R00!A
X-PGP-Key: http://schabi.de/pubkey.asc
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, DervishD,

On Wed, 28 Jul 2004 16:47:23 +0200
DervishD <raul@pleyades.net> wrote:

>     Now, is there any sysctl that enables a keepalive for this kind
> of connections (dead remote end, local in CLOSE_WAIT) for all
> connections?

Hmm, on my 2.6.4 kernel, I have 

/proc/sys/net/ipv4$ for i in tcp_keepalive_* ; do echo $i $(cat $i) ; done
tcp_keepalive_intvl 75
tcp_keepalive_probes 9
tcp_keepalive_time 7200

So it seems those are only the tuning values for the keepalive. Linux
(following RFC112) by default waits for 7200 seconds = 2 hours before it
sends the probes. The reason for this is that idle connections (like
ssh) should not be dropped just because there are some temporary network
problems between the hosts. (See man tcp for details.)

It seems that there's no global enabling if you don't want to tweak the
kernel source yourself.

Markus



-- 
markus schaber | dipl. informatiker
logi-track ag | rennweg 14-16 | ch 8001 zürich
phone +41-43-888 62 52 | fax +41-43-888 62 53
mailto:schabios@logi-track.com | www.logi-track.com
