Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUEXUiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUEXUiK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbUEXUiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:38:10 -0400
Received: from hyperion.haystack.edu ([192.52.65.1]:35475 "EHLO
	hyperion.haystack.edu") by vger.kernel.org with ESMTP
	id S264373AbUEXUhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:37:15 -0400
Message-ID: <40B25CFA.3000105@haystack.mit.edu>
Date: Mon, 24 May 2004 16:37:14 -0400
From: Frank Lind <flind@haystack.mit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: knobi@knobisoft.de
Subject: Multicast problems between 2.4.20 and 2.4.21?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Was there ever a resolution to the multicast issues with kernels beyond 
2.4.20?

I have a very similar problem that has shown up with code which works 
fine prior with  2.4.20-6smp (Redhat 9) and then stops working for later 
kernels. I ran into this upgrading a machine to RedHat Enterprise 
(2.4.21-9.ELsmp) but it also happens under Fedora (2.6.5-1.358smp). I 
was going to try some separate kernel compiles and also a different 
distribution when I get a chance to try to localize the change. I 
haven't been able to find a clear reason why this is happening yet. I 
was wondering if anyone had any additional insights beyond what showed 
up in the kernel mailing lists so far (i.e. Any changes in Multicast 
code between 2.4.20 and 2.4.22/23)?

I am able to get the multicasting to work under these kernels by 
changing my bind calls to use the INADDR_ANY instead of binding to the 
address and port I'm using for the multicast group. I haven't found good 
documentation that this is the "correct" way to do this but I ran into 
some comments for multicast under ipv6 which made me think it was worth 
a try. This substitution gets the machines multicasting but I've had 
some problems that appear to be the switch selectively deciding to 
deliver data or not depending on if certain machines connect to the 
multicast group. (This needs more testing but basically if a machine 
using the 2.4.20 kernel joins then some of the newer kernel machines 
stop getting packets for reasons I don't understand yet).

I noted it was asked why the network switch might matter. There is a 
note from HP on their Procurve switches indicates that certain IP 
addresses are not IGMP filtered. In particular 224.0.0.x gets no IGMP 
filtering :

http://www.hp.com/rnd/pdfs/IGMP_Tech_Note.pdf

I got bit by this one a while back in that my network was getting 
flooded despite using IGMP in the code.

-- Frank

-- 
Frank D. Lind			email: flind@haystack.mit.edu	
MIT Haystack Observatory	WWW: http://www.haystack.mit.edu
Route 40			tel: 781 981 5570
Westford, MA  01886  USA	fax: 781 981 5766



