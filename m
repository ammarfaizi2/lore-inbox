Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTFEDMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 23:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTFEDMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 23:12:53 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:38287 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264437AbTFEDMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 23:12:51 -0400
Date: Wed, 4 Jun 2003 20:26:22 -0700
From: Andrew Morton <akpm@digeo.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: shemminger@osdl.org, jgarzik@pobox.com, davem@redhat.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk+ broken networking
Message-Id: <20030604202622.1be40092.akpm@digeo.com>
In-Reply-To: <20030605023349.GH24515@conectiva.com.br>
References: <20030604161437.2b4d3a79.shemminger@osdl.org>
	<3EDE7FEB.2C7FAEC7@digeo.com>
	<20030604185652.31958d1f.akpm@digeo.com>
	<20030605023349.GH24515@conectiva.com.br>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 03:26:22.0152 (UTC) FILETIME=[3C88F480:01C32B12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

broken "cleanup"

 net/core/iovec.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN net/core/iovec.c~iovec-fix net/core/iovec.c
--- 25/net/core/iovec.c~iovec-fix	2003-06-04 20:23:03.000000000 -0700
+++ 25-akpm/net/core/iovec.c	2003-06-04 20:24:05.000000000 -0700
@@ -47,9 +47,10 @@ int verify_iovec(struct msghdr *m, struc
 						  address);
 			if (err < 0)
 				return err;
-			m->msg_name = address;
-		} else
-			m->msg_name = NULL;
+		}
+		m->msg_name = address;
+	} else {
+		m->msg_name = NULL;
 	}
 
 	size = m->msg_iovlen * sizeof(struct iovec);

_

