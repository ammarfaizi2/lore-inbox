Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTKBUrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 15:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTKBUrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 15:47:00 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:45184
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S261807AbTKBUqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 15:46:55 -0500
Date: Sun, 2 Nov 2003 15:46:27 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jariruusu@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-ID: <20031102204624.GA5740@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@paranoiacs.org>,
	Andrew Morton <akpm@osdl.org>, jariruusu@users.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org> <20031101002650.GA7397@fukurou.paranoiacs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20031101002650.GA7397@fukurou.paranoiacs.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My astute and obviously flawless technical analysis seems to be at odds
with the benchmarks, which show reads completed in half the time with
Andrew's patches as with mine. Writes are a little slower tho'.

Results attached.

-- 
Ben Slusky                      | Some drink from the Fountain
sluskyb@paranoiacs.org          | of Knowledge... Others just
sluskyb@stwing.org              | gargle. ...And some pee in it.
PGP keyID ADA44B3B              |               -Dave Aronson

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=times-sluskyb


Write test:
time sh -c 'dd if=/dev/urandom of=testfoo bs=32k count=5000 conv=notrunc; sync'
0.03user 131.66system 2:26.62elapsed 89%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 133.35system 2:34.15elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.04user 133.35system 2:30.97elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 131.64system 2:29.25elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.04user 128.32system 2:26.25elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 130.65system 2:28.31elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 128.49system 2:25.50elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.04user 128.48system 2:26.03elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 128.63system 2:25.96elapsed 88%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 127.40system 2:24.91elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps

Read test:
time dd if=testfoo of=/dev/null bs=32k
0.04user 1.45system 0:37.20elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.05user 1.45system 0:37.07elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.42system 0:37.10elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.05user 1.46system 0:37.12elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.44system 0:37.13elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.05user 1.43system 0:37.10elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.05user 1.44system 0:37.23elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.43system 0:37.07elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.05user 1.44system 0:37.13elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.05user 1.43system 0:37.12elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps

Read/Write test:
time sh -c 'tar xjf src/linux-2.6.0-test1.tar.bz2; sync'
58.32user 20.09system 1:58.83elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
58.86user 18.22system 1:57.10elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
59.00user 17.58system 1:56.83elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
59.28user 17.49system 1:57.10elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
58.84user 18.19system 1:56.98elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
58.82user 17.74system 1:56.15elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
58.89user 17.71system 1:57.00elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
59.07user 17.82system 1:57.33elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
59.36user 18.29system 1:57.05elapsed 66%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
59.14user 17.59system 1:56.91elapsed 65%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=times-akpm

Write test:
time sh -c 'dd if=/dev/urandom of=testfoo bs=32k count=5000 conv=notrunc; sync'
0.05user 131.32system 2:36.10elapsed 84%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 137.84system 2:40.38elapsed 85%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.02user 137.72system 2:40.32elapsed 85%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 137.09system 2:39.38elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.04user 136.31system 2:38.62elapsed 85%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.04user 135.40system 2:37.26elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 133.00system 2:33.92elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.03user 134.56system 2:35.92elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.04user 133.76system 2:35.15elapsed 86%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (439major+100minor)pagefaults 0swaps
0.04user 133.41system 2:35.23elapsed 85%CPU (0avgtext+0avgdata 0maxresident)k

Read test:
time dd if=testfoo of=/dev/null bs=32k
0.03user 1.37system 0:18.46elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.37system 0:18.20elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.32system 0:17.85elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.30system 0:17.66elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.31system 0:17.67elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.30system 0:17.67elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.05user 1.27system 0:17.65elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.30system 0:17.64elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.35system 0:18.09elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps
0.04user 1.38system 0:18.42elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (364major+75minor)pagefaults 0swaps

Read/Write test:
time sh -c 'tar xjf src/linux-2.6.0-test1.tar.bz2; sync'
60.41user 13.18system 1:57.85elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.37user 13.26system 1:58.74elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.59user 13.30system 1:57.83elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.53user 13.25system 1:58.48elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.41user 13.29system 1:58.47elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.46user 13.33system 1:57.36elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.44user 13.07system 1:59.50elapsed 61%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.14user 13.12system 1:58.03elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.28user 13.18system 1:58.58elapsed 61%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps
60.44user 13.32system 1:58.93elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (623major+1033minor)pagefaults 0swaps

--1yeeQ81UyVL57Vl7--
