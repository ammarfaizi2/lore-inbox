Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270857AbRHNU7x>; Tue, 14 Aug 2001 16:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270854AbRHNU7o>; Tue, 14 Aug 2001 16:59:44 -0400
Received: from mail.zabbadoz.net ([195.2.176.194]:8457 "EHLO mail.zabbadoz.net")
	by vger.kernel.org with ESMTP id <S270858AbRHNU72>;
	Tue, 14 Aug 2001 16:59:28 -0400
Date: Tue, 14 Aug 2001 22:59:36 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb+linuxkernel@zabbadoz.net>
To: Chris Crowther <chrisc@shad0w.org.uk>
cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: Re: [PATCH] CDP handler for linux
In-Reply-To: <Pine.LNX.4.33.0108142050550.3683-100000@monolith.shad0w.org.uk>
Message-ID: <Pine.BSF.4.30.0108142219200.38503-100000@noc.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Chris Crowther wrote:

[snipped out everything]

Hi,

just give give my three cents to this:

- should soemthing like this really go into kernel ?
  (as others mentioned too)

- there are major gaps in there that should be filled first
  CDP Version 2 is also available but not (yet) well documented

enum {
        CDP_DEVICE_ID           = 0x0001,
        CDP_ADDRESS,            /* '0002 */
                #define CDP_ADDR_PROTO_TYPE_NLPID       1
                  #define CDP_ADDR_PROTO_ISOCLNS        0x81
                  #define CDP_ADDR_PROTO_IP             0xcc
                #define CDP_ADDR_PROTO_TYPE_8022        2
		  /* .. [snip] .. */
        CDP_PORT_ID,            /* '0003 */
        CDP_CAPABILITIES,       /* '0004 */
        CDP_VERSION,            /* '0005 */
        CDP_PLATFORM,           /* '0006 */
        CDP_IP_PREFIX,          /* '0007 */
        CDP_PROTOCOL_HELLO,     /* '0008 */
        CDP_VTP_MGMT_DOM,       /* '0009 */
        CDP_NATIVE_VLAN_ID,     /* '000a */
        CDP_DUPLEX_MODE         /* '000b */
} cdp_data_type_e;

is all that I ever found out about this.

see also tcpdump or ethereal for userspace decoders to fill some gaps
(decoding...)


- code looks fine but after skimming over I think it's exploitable to
  malformed cdp packets easily generated with a short proggi (already
  exists)
  The idea there is giving p.ex. a longer length for some type than
  whole packets is actually long. This will lead to accessing (and
  later printing if we were still alive without an oops) illegal
  memory addresses in cdp_update_neighbor()


-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

