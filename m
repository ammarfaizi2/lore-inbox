Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUHZKfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUHZKfT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHZKe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:34:57 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:10912
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S268045AbUHZKbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:31:16 -0400
Message-ID: <412DBBF0.3090107@bio.ifi.lmu.de>
Date: Thu, 26 Aug 2004 12:31:12 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Broadbent <markb@wetlettuce.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1: ip auto-config accepts wrong packages
References: <412C5E80.8050603@bio.ifi.lmu.de>	 <1093439062.25506.12.camel@mbpc.signal.qinetiq.com>	 <412CA518.7090109@bio.ifi.lmu.de> <1093448839.25506.57.camel@mbpc.signal.qinetiq.com>
In-Reply-To: <1093448839.25506.57.camel@mbpc.signal.qinetiq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

in addition to the DEBUG flags I added two little debugging lines to make
sure the right code is executed.

ipconfig.c:
			if (able & IC_BOOTP){
			  DBG(("calling get_random_btyes"));
				get_random_bytes(&d->xid, sizeof(u32));

random.c:

	void get_random_bytes(void *buf, int nbytes)
	{
	  DEBUG_ENT("get_random_bytes entered\n");
	  if (sec_random_state) {
	    DEBUG_ENT("sec_random_state\n");
	    extract_entropy(sec_random_state, (char *) buf, nbytes,
			    EXTRACT_ENTROPY_SECONDARY);
	  }


And here is the output from boot.msg:


<4>IP-Config: Entered.
<4>calling get_random_btyes<7>random: get_random_bytes entered
<7>random: sec_random_state
<7>random: 0000 0000 : going to reseed secondary with 64 bits (32 of 0 requested)
<7>random: 0000 0000 : trying to extract 64 bits from primary
<7>random: 0000 0000 : debiting 0 bits from primary
<7>random: 0000 0000 : trying to extract 32 bits from secondary
<7>random: 0000 0000 : debiting 32 bits from secondary (unlimited)
<4>IP-Config: eth0 UP (able=1, xid=07196018)
<5>Sending BOOTP requests .<7>random: get_random_bytes entered
<7>random: sec_random_state
<7>random: 0000 0000 : going to reseed secondary with 64 bits (32 of 0 requested)
<7>random: 0000 0000 : trying to extract 64 bits from primary
<7>random: 0000 0000 : debiting 0 bits from primary
<7>random: 0000 0000 : trying to extract 32 bits from secondary
<7>random: 0000 0000 : debiting 32 bits from secondary (unlimited)
<6>tg3: eth0: Link is up at 100 Mbps, full duplex.
<6>tg3: eth0: Flow control is on for TX and on for RX.
<4>.DHCP/BOOTP: Got extension 1: ff ff ff 80
<4>DHCP/BOOTP: Got extension 3: 8d 54 01 82
<4>DHCP/BOOTP: Got extension 6: 81 bb d6 87
<4>DHCP/BOOTP: Got extension 17: 2f
<4>DHCP/BOOTP: Got extension 28: 8d 54 01 ff
<4>DHCP/BOOTP: Got extension 15: 62 69 6f 2e 69 66 69 2e 6c 6d 75 2e 64 65
<4> OK
<4>IP-Config: Got BOOTP answer from 141.84.1.132, my address is 141.84.1.167
...

So it looks like the code is executed, but the xid is always the
same. Just like the random module would not create a random number
but a constant :-) I'm not good enough in C to really understand
and further debug the code in random.c or ipconfig.c :-((

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
