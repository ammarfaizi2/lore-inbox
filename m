Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278561AbRJSRdG>; Fri, 19 Oct 2001 13:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278562AbRJSRcr>; Fri, 19 Oct 2001 13:32:47 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:53472 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278561AbRJSRcl>; Fri, 19 Oct 2001 13:32:41 -0400
Date: 19 Oct 2001 19:09:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8B9P9PwHw-B@khms.westfalen.de>
In-Reply-To: <20011018220604.23253@smtp.wanadoo.fr>
Subject: Re: [RFC] New Driver Model for 2.5
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org> <Pine.LNX.4.21.0110180826240.16868-100000@marty.infinity.powertie.org> <20011018220604.23253@smtp.wanadoo.fr>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

benh@kernel.crashing.org (Benjamin Herrenschmidt)  wrote on 19.10.01 in <20011018220604.23253@smtp.wanadoo.fr>:

> collisions between uuid's of different devices types. In the case of
> ethernet hardware, the MAC address seems to be the best type of uuid
> available, so it would be something like "ethaddr,xx:xx:xx:xx:xx:xx",
> FireWire has a generic uuid allocation scheme as well, it could be
> "ieee1394,xxxxxx...", etc...

I have no idea what Firewire uses, but there are two generic kinds of  
numbers that the IEEE allocates (actually, they're two different views on  
a single id space).

Those are the MAC-48 address used by ethernet, fddi, and various other  
protocols, and the EUI-64 used by more modern designs (and referenced by  
IPv6; in fact, there's an algorithm that lets you create an EUI-64 from a  
MAC-48 via bit stuffing).

Both of these depend on a 24 bit id called company_id or OUI which you can  
buy from the IEEE for US$1.250,00 (for 16 million MAC-48's or 1 trillion  
EUI-64's).

The list of public OUIs is at <URL:http://standards.ieee.org/regauth/oui/ 
oui.txt> (there are "unlisted numbers" in that namespace, too).

Ah, I see IEEE 1394 *does* use OUIs. Not at all surprising, of course.

So, the namespace should be used, not the appliation. In fact, given the  
standard conversion from MAC-48 to EUI-64, we should probably just use one  
namespace for both: my current ethernet card 00:50:FC:0C:63:69 would thus  
be named "eui-64,00:50:fc:ff:ff:0c:63:69".

More than you ever wanted to know about this stuff: <URL:http:// 
standards.ieee.org/regauth/oui/>.

Of course, there *are* other namespaces.

MfG Kai
