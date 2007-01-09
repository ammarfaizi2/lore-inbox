Return-Path: <linux-kernel-owner+w=401wt.eu-S1750886AbXAIBYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbXAIBYI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 20:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbXAIBYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 20:24:08 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:45315 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbXAIBYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 20:24:06 -0500
Date: Tue, 09 Jan 2007 10:24:53 +0900 (JST)
Message-Id: <20070109.102453.32711440.yoshfuji@linux-ipv6.org>
To: craig@codefountain.com
Cc: komurojun-mbn@nifty.com, bunk@stusta.de, jgarzik@pobox.com,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org
Subject: Re: [BUG KERNEL 2.6.20-rc1] ftp: get or put stops during
 file-transfer
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20070104122330.GA2233@craigdell.detnet.com>
References: <20061230.231952.16573563.yoshfuji@linux-ipv6.org>
	<20070105054546.953196e5.komurojun-mbn@nifty.com>
	<20070104122330.GA2233@craigdell.detnet.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20070104122330.GA2233@craigdell.detnet.com> (at Thu, 4 Jan 2007 14:23:30 +0200), Craig Schlenter <craig@codefountain.com> says:

> On Fri, Jan 05, 2007 at 05:45:46AM +0900, Komuro wrote:
> > Hi,
> > 
> > I made a patch below.
> > With this patch, the ftp-transfer-stop problem does not happen.
> > Therefore, I think this is not a problem of vsftpd.
> > 
> > Mr.YOSHIFUJI san, why did you set TCPOLEN_TSTAMP_ALIGNED
> > to iov_len?
> > 
> > 
> > 
> > --- linux-2.6.20-rc3/net/ipv4/tcp_ipv4.c.orig	2007-01-03 11:50:04.000000000 +0900
> > +++ linux-2.6.20-rc3/net/ipv4/tcp_ipv4.c	2007-01-03 15:30:44.000000000 +0900
> > @@ -648,7 +648,7 @@ static void tcp_v4_send_ack(struct tcp_t
> >  				   TCPOLEN_TIMESTAMP);
> >  		rep.opt[1] = htonl(tcp_time_stamp);
> >  		rep.opt[2] = htonl(ts);
> > -		arg.iov[0].iov_len = TCPOLEN_TSTAMP_ALIGNED;
> > +		arg.iov[0].iov_len = sizeof(rep);
> 
> Perhaps this was supposed to be
>                 arg.iov[0].iov_len += TCPOLEN_TSTAMP_ALIGNED;
> 
> That's what the ipv6 stuff does in places.

Good catch! I agree.
Craig, please provide a patch for us, please.

Thank you again.

--yoshfuji
