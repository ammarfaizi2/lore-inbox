Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbSIPXrp>; Mon, 16 Sep 2002 19:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263405AbSIPXrp>; Mon, 16 Sep 2002 19:47:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36328 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263374AbSIPXrp>;
	Mon, 16 Sep 2002 19:47:45 -0400
Date: Mon, 16 Sep 2002 16:43:43 -0700 (PDT)
Message-Id: <20020916.164343.128145825.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, todd-lkml@osogrande.com,
       hadi@cyberus.ca, tcw@tempest.prismnet.com, netdev@oss.sgi.com,
       pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D866DD5.4080207@mandrakesoft.com>
References: <3D86645F.5030401@mandrakesoft.com>
	<20020916.160210.70782700.davem@redhat.com>
	<3D866DD5.4080207@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Mon, 16 Sep 2002 19:48:37 -0400

   I dunno when it happened, but 2.5.x now returns EINVAL for all 
   file->file cases.
   
   In 2.4.x, if sendpage is NULL, file_send_actor in mm/filemap.c faked a 
   call to fops->write().
   In 2.5.x, if sendpage is NULL, EINVAL is unconditionally returned.
   

What if source and destination file and offsets match?
Sounds like 2.4.x might deadlock.

In fact it sounds similar to the "read() with buf pointed to same
page in MAP_WRITE mmap()'d area" deadlock we had ages ago.
