Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272253AbTG3V1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272275AbTG3VZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:25:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59092 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272273AbTG3VZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:25:41 -0400
Date: Wed, 30 Jul 2003 17:24:36 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1 & ipsec-tools (xfrm_type_2_50?)
In-Reply-To: <20030730210414.GA28308@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.56.0307301710550.26621@onqynaqf.yrkvatgba.voz.pbz>
References: <Pine.LNX.4.56.0307301515250.26621@onqynaqf.yrkvatgba.voz.pbz>
 <20030730210414.GA28308@outpost.ds9a.nl>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, bert hubert wrote:

> I recently tested all this again with 2.6.0-test2 and It Just Worked, so I
> can't confirm this.

with an all modular build ?

> I run with a very minimal racoon.conf, almost exactly the one found on
> http://lartc.org/howto/lartc.ipsec.html

ditto

> I'd suggest posting the relevant bits of your .config

!/usr/sbin/setkey -f
flush;
spdflush;
spdadd 9.30.62.131 9.51.94.26 any -P out ipsec
        esp/transport//require;
spdadd 9.51.94.26 9.30.62.131 any -P in ipsec
        esp/transport//require;

/etc/racoon/racoon.conf
remote 9.51.94.26
{
	exchange_mode main;
	my_identifier asn1dn;
	peers_identifier asn1dn;
	certificate_type x509 "<cert>" "<key>";
	peers_certfile "<remote cert>";
	proposal {
        encryption_algorithm 3des;
		hash_algorithm sha1;
		authentication_method rsasig;
		dh_group modp1536 ;
	}
}
sainfo anonymous
{
    pfs_group modp1536;
    encryption_algorithm 3des ;
    authentication_algorithm hmac_sha1 ;
    compression_algorithm deflate ;
}

Again, the remote is freeswan 1.96


> Good luck!
Thanks, I'll probably be needing it :)

-- 
Rick Nelson
I can saw a woman in two, but you won't want to look in the box when I do
'For My Next Trick I'll Need a Volunteer' -- Warren Zevon
