Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTIVLHJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 07:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTIVLHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 07:07:08 -0400
Received: from port-212-202-185-245.reverse.qdsl-home.de ([212.202.185.245]:40159
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S263108AbTIVLHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 07:07:07 -0400
Message-ID: <3F6ED82E.5060606@trash.net>
Date: Mon, 22 Sep 2003 13:08:30 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
CC: Diadon <diadon@isfera.ru>, David Miller <davem@redhat.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] fix ipt_REJECT when used in OUTPUT
References: <20030921144013.GA22223@sunbeam.de.gnumonks.org> <3F6EAFF2.9080303@isfera.ru> <20030922085326.GF31401@sunbeam.de.gnumonks.org>
In-Reply-To: <20030922085326.GF31401@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:

>David, pleas defer applying that patch until further testing is done.
>
>Sorry for the confusion.
>

My bad, I missed that we cannot pass the packet to ip_finish_output2
since it was routed as local input and is missing a neighbour. The correct
fix is to use ip_route_output for packets generated in LOCAL_OUT with
key.saddr set to 0 (the first one I sent to Diadon).

Best regards,
Patrick

