Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFDFVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTFDFVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:21:08 -0400
Received: from palrel13.hp.com ([156.153.255.238]:23261 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261797AbTFDFVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:21:07 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16093.34022.445246.52398@napali.hpl.hp.com>
Date: Tue, 3 Jun 2003 22:34:30 -0700
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, jmorris@intercode.com.au, gandalf@wlug.westbo.se,
       linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
       netdev@oss.sgi.com, akpm@digeo.com
Subject: Re: fix TCP roundtrip time update code
In-Reply-To: <3EDD7832.7010804@us.ibm.com>
References: <200306040043.EAA24505@dub.inr.ac.ru>
	<3EDD52F5.8090706@us.ibm.com>
	<20030603.202320.59680883.davem@redhat.com>
	<16093.30507.661714.676184@napali.hpl.hp.com>
	<3EDD7832.7010804@us.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 03 Jun 2003 21:40:18 -0700, Nivedita Singhvi <niv@us.ibm.com> said:

  Nivedita> David Mosberger wrote:
  DaveM> So if your old SpecWEB99 lab tended more to trigger timeout
  DaveM> based retransmits on LAN, and your new test network does not,
  DaveM> then your new test network will tend to not reproduce the bug
  DaveM> regardless of whether the bug is present in the kernel or not
  DaveM> :-)

  >>  Is this where I get to plug httperf?  It triggered the bug
  >> reliably in less than 10 secs. ;-)

  Nivedita> Tarnation!! Ran httperf! Didnt hit it! :(. What were your
  Nivedita> settings?

I used:

 $ httperf --rate 1000 --num-conns 1000000 --verbose --hog --server HOST \
	--uri pathto30KBfile

on 3 clients (for a total of 3000 conns/sec).  You can't go higher
than 1000 conn/sec per client (IP address) because otherwise you run
out of port space (due to TIME_WAIT).

This load worked well for a machine with a single GigE card.  All
network tunables were on the default setting (in particular, the tx
queue len was 300, which is were the losses came from).

With this load, I saw bad RTT values in the route cache within a
couple of seconds after starting the third httperf generator.  It then
took a bit longer (on the order of 1-2 minutes) until the first
TCPAbortFailed errors started to pop up.

	--david
