Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbRGBIsj>; Mon, 2 Jul 2001 04:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266412AbRGBIs3>; Mon, 2 Jul 2001 04:48:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9408 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266408AbRGBIsV>;
	Mon, 2 Jul 2001 04:48:21 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15168.13648.602917.563647@pizda.ninka.net>
Date: Mon, 2 Jul 2001 01:48:16 -0700 (PDT)
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang from HUP'ing init in linuxrc
In-Reply-To: <15167.61332.139916.158874@cargo.ozlabs.ibm.com>
In-Reply-To: <15167.61332.139916.158874@cargo.ozlabs.ibm.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Mackerras writes:
 > What was happening was rather interesting.  The init process was stuck
 > inside prepare_namespace(), in the while loop here (this is lines 749
 > - 751 of init/main.c):
 > 
 > 		pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 > 		if (pid>0)
 > 			while (pid != wait(&i));
 > 
 ...
 [ no signal delivery due to returning to kernel space, blah blah blah
   :-) ]

For 2.4.x I'd just check for sigpending in this wait loop.

Longer term (ie. 2.5.x and onward) we should look into ideas like those
mentioned by Ben.  I for one would not complain about seeing dhcp
getting removed from the kernel :-)

Later,
David S. Miller
davem@redhat.com

