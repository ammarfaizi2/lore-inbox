Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUFWKfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUFWKfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 06:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUFWKfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 06:35:19 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:58893 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265207AbUFWKfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 06:35:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Martin Zwickel <martin.zwickel@technotrend.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2 udp multicast problem (sendto hangs)
Date: Wed, 23 Jun 2004 13:34:57 +0300
X-Mailer: KMail [version 1.4]
References: <20040622164000.110f2a63@phoebee> <20040623115617.68b93100@phoebee>
In-Reply-To: <20040623115617.68b93100@phoebee>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200406231334.57816.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 June 2004 12:56, Martin Zwickel wrote:
> if I use MSG_DONTWAIT with sendto, I get temporarily unavailable resources
> (many!):
>
> sendto(sendfd): Resource temporarily unavailable
>
> but isn't udp supposed to not block?

Think about what will happen if you will try to spew
udp packets continuously:

while(1)
	sendto(...);

They will pile up in queue and eventually it will fill up.
Then kernel may either drop excess packets silently
or return you EAGAIN.
-- 
vda
