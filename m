Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTBERJu>; Wed, 5 Feb 2003 12:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbTBERJu>; Wed, 5 Feb 2003 12:09:50 -0500
Received: from cs78149057.pp.htv.fi ([62.78.149.57]:31670 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S262394AbTBERJp>;
	Wed, 5 Feb 2003 12:09:45 -0500
Subject: Re: disabling nagle
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Dave Slicer <slice1900@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200302050648.h156mxs16371@Port.imtp.ilyichevsk.odessa.ua>
References: <F137jnt61tqeaVRMPjc00012673@hotmail.com>
	 <200302050648.h156mxs16371@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044465519.1516.23.camel@devil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 19:18:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 08:47, Denis Vlasenko wrote:
> On 5 February 2003 02:01, Dave Slicer wrote:
> > Others already answered this specific question, but I wonder how hard
> > it would be to create a patch to disable TCP's timeout and retransmit
> > mechanisms on a given interface?  This would allow those of us who
> > have no alternative other than PPP over ssh for VPN to greatly
> > improve performance. Over a well behaved connection this works
> > acceptably, but given any delays or packet loss it is essentially
> > unusable.  I know the real answer is using something other than TCP
> > as the transport layer for the tunnel (IPSEC, IP over IP, UDP, etc.)
> > but that isn't always possible.  So I'd like a way to treat the ppp
> > interface the VPN tunnel creates as a completely reliable transport
> > for which normal TCP/IP retransmits and timeouts don't apply. It'd
> > just bullheadedly go along transmitting data and assuming it was
> > received -- the underlying TCP transport can take care of making the
> > link reliable.
> 
> I want this too ;) For one, it would be a perfect example of using
> good existing tools to achieve the goal instead of inventing
> something big and new. Also it does not reduce MTU unlike
> packet-encapsulation tunnels.
> 
> Now it's an imperfect example due to noted TCP over TCP performance
> problem ('internal meltdown').

I doubt a hack like disabling RTO would make it into the kernel.
However, try enabling F-RTO at both ends (echo 1 >
/proc/sys/net/ipv4/tcp_frto). This should improve things quite a bit.

You need at least linux 2.4.21-pre3, or linux 2.5.x.

	MikaL

