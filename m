Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269109AbUHZQgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269109AbUHZQgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUHZQgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:36:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:48297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269185AbUHZQ2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:28:14 -0400
Date: Thu, 26 Aug 2004 09:17:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: markb@wetlettuce.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1: ip auto-config accepts wrong packages
Message-Id: <20040826091722.54a0cc72.rddunlap@osdl.org>
In-Reply-To: <412DBBF0.3090107@bio.ifi.lmu.de>
References: <412C5E80.8050603@bio.ifi.lmu.de>
	<1093439062.25506.12.camel@mbpc.signal.qinetiq.com>
	<412CA518.7090109@bio.ifi.lmu.de>
	<1093448839.25506.57.camel@mbpc.signal.qinetiq.com>
	<412DBBF0.3090107@bio.ifi.lmu.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 12:31:12 +0200 Frank Steiner wrote:

| Hi Mark,
| 
| in addition to the DEBUG flags I added two little debugging lines to make
| sure the right code is executed.
| 
| ipconfig.c:
| 			if (able & IC_BOOTP){
| 			  DBG(("calling get_random_btyes"));
| 				get_random_bytes(&d->xid, sizeof(u32));
| 
| random.c:
| 
| 	void get_random_bytes(void *buf, int nbytes)
| 	{
| 	  DEBUG_ENT("get_random_bytes entered\n");
| 	  if (sec_random_state) {
| 	    DEBUG_ENT("sec_random_state\n");
| 	    extract_entropy(sec_random_state, (char *) buf, nbytes,
| 			    EXTRACT_ENTROPY_SECONDARY);
| 	  }
| 
| 
| And here is the output from boot.msg:
| 
| 
| <4>IP-Config: Entered.
| <4>calling get_random_btyes<7>random: get_random_bytes entered
| <7>random: sec_random_state
| <7>random: 0000 0000 : going to reseed secondary with 64 bits (32 of 0 requested)
| <7>random: 0000 0000 : trying to extract 64 bits from primary
| <7>random: 0000 0000 : debiting 0 bits from primary
| <7>random: 0000 0000 : trying to extract 32 bits from secondary
| <7>random: 0000 0000 : debiting 32 bits from secondary (unlimited)
| <4>IP-Config: eth0 UP (able=1, xid=07196018)
| <5>Sending BOOTP requests .<7>random: get_random_bytes entered
| <7>random: sec_random_state
| <7>random: 0000 0000 : going to reseed secondary with 64 bits (32 of 0 requested)
| <7>random: 0000 0000 : trying to extract 64 bits from primary
| <7>random: 0000 0000 : debiting 0 bits from primary
| <7>random: 0000 0000 : trying to extract 32 bits from secondary
| <7>random: 0000 0000 : debiting 32 bits from secondary (unlimited)
| <6>tg3: eth0: Link is up at 100 Mbps, full duplex.
| <6>tg3: eth0: Flow control is on for TX and on for RX.
| <4>.DHCP/BOOTP: Got extension 1: ff ff ff 80
| <4>DHCP/BOOTP: Got extension 3: 8d 54 01 82
| <4>DHCP/BOOTP: Got extension 6: 81 bb d6 87
| <4>DHCP/BOOTP: Got extension 17: 2f
| <4>DHCP/BOOTP: Got extension 28: 8d 54 01 ff
| <4>DHCP/BOOTP: Got extension 15: 62 69 6f 2e 69 66 69 2e 6c 6d 75 2e 64 65
| <4> OK
| <4>IP-Config: Got BOOTP answer from 141.84.1.132, my address is 141.84.1.167
| ...
| 
| So it looks like the code is executed, but the xid is always the
| same. Just like the random module would not create a random number
| but a constant :-) I'm not good enough in C to really understand
| and further debug the code in random.c or ipconfig.c :-((

Maybe fixed by
http://linux.bkbits.net:8080/linux-2.5/cset@412a4a00MfXRfzWB5kTFo9NXM1Q3hw?nav=index.html|ChangeSet@-7d

i.e., fix is already merged, I think.

--
~Randy
