Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVAWIRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVAWIRz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 03:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVAWIRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 03:17:55 -0500
Received: from opersys.com ([64.40.108.71]:62986 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261256AbVAWIRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 03:17:54 -0500
Message-ID: <41F3602E.9050204@opersys.com>
Date: Sun, 23 Jan 2005 03:28:30 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de> <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home> <41E8358A.4030908@opersys.com> <Pine.LNX.4.61.0501150101010.30794@scrub.home> <41E899AC.3070705@opersys.com> <Pine.LNX.4.61.0501160245180.30794@scrub.home> <41EA0307.6020807@opersys.com> <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com> <Pine.LNX.4.61.0501171403490.30794@scrub.home> <41EC2DCA.50904@opersys.com> <Pine.LNX.4.61.0501172323310.30794@scrub.home> <41EC8AA2.1030000@opersys.com> <Pine.LNX.4.61.0501181359250.30794@scrub.home> <41F0A0A2.1010109@opersys.com> <Pine.LNX.4.61.0501211754110.30794@scrub.home> <41F355AD.50901@opersys.com>
In-Reply-To: <41F355AD.50901@opersys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Karim Yaghmour wrote:
> This is not good for any client that doesn't know beforehand the exact
> size of their data units, as in the case of LTT. If LTT has to use this
> code that means we are going to loose performance because we will need to
> fill an intermediate data structure which will only be used for relay_write().
> Instead of zero-copy, we would have an extra unnecessary copy. There has
> got to be a way for clients to directly reserve and write as they wish.
> Even Zach Brown recognized this in his tracepipe proposal, here's from
> his patch:
> + * 	- let caller reserve space and get a pointer into buf

Also, if the reserve is exported, then a client that chooses so, can
do something like:

	local_irq_save();
	relay_reserve();
	write(); write(); write(); ...
	local_irq_restore();

And therefore enforce in-order events is he so chooses.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
