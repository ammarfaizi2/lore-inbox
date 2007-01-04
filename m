Return-Path: <linux-kernel-owner+w=401wt.eu-S964800AbXADLqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbXADLqb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 06:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbXADLqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 06:46:31 -0500
Received: from userg503.nifty.com ([202.248.238.83]:21304 "EHLO
	userg503.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964800AbXADLqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 06:46:30 -0500
DomainKey-Signature: a=rsa-sha1; s=userg503; d=nifty.com; c=simple; q=dns;
	b=kSy72UUQuhGrXIN1oEM3V5fopHf05NuAanL92bwp+F5rwsZnNoFuXx9LuVQ3ogTC2
	ozzSo2VTyeRskJJqc8QyA==
Date: Fri, 5 Jan 2007 05:45:46 +0900
From: Komuro <komurojun-mbn@nifty.com>
To: YOSHIFUJI Hideaki / =?ISO-2022-JP?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Cc: bunk@stusta.de, jgarzik@pobox.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [BUG KERNEL 2.6.20-rc1] ftp: get or put stops during
 file-transfer
Message-Id: <20070105054546.953196e5.komurojun-mbn@nifty.com>
In-Reply-To: <20061230.231952.16573563.yoshfuji@linux-ipv6.org>
References: <20061230185043.d31d2104.komurojun-mbn@nifty.com>
	<20061230.102358.106876516.yoshfuji@linux-ipv6.org>
	<20061230205931.9e430173.komurojun-mbn@nifty.com>
	<20061230.231952.16573563.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I made a patch below.
With this patch, the ftp-transfer-stop problem does not happen.
Therefore, I think this is not a problem of vsftpd.

Mr.YOSHIFUJI san, why did you set TCPOLEN_TSTAMP_ALIGNED
to iov_len?



--- linux-2.6.20-rc3/net/ipv4/tcp_ipv4.c.orig	2007-01-03 11:50:04.000000000 +0900
+++ linux-2.6.20-rc3/net/ipv4/tcp_ipv4.c	2007-01-03 15:30:44.000000000 +0900
@@ -648,7 +648,7 @@ static void tcp_v4_send_ack(struct tcp_t
 				   TCPOLEN_TIMESTAMP);
 		rep.opt[1] = htonl(tcp_time_stamp);
 		rep.opt[2] = htonl(ts);
-		arg.iov[0].iov_len = TCPOLEN_TSTAMP_ALIGNED;
+		arg.iov[0].iov_len = sizeof(rep);
 	}
 
 	/* Swap the send and the receive. */


Best Regards
Komuro

