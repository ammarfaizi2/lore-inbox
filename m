Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVEMXIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVEMXIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 19:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVEMXIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 19:08:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:47503 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262433AbVEMXHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 19:07:38 -0400
Message-ID: <4285332D.1060808@pobox.com>
Date: Fri, 13 May 2005 19:07:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Benjamin LaHaise <bcrl@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [rfc/patch] libata -- port configurable delays
References: <20050513185850.GA5777@kvack.org> <4284FC6E.7060300@pobox.com>	 <20050513200312.GA6555@kvack.org> <1116021178.20545.3.camel@localhost.localdomain>
In-Reply-To: <1116021178.20545.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>>4) It may be worthwhile to rewrite the loop to check the Status register 
>>>_first_, then delay.
> 
> 
> The 400nS delay after a command is required before status becomes valid.
> This isn't about 'incorrect' devices in the command case. It is about
> strictly correct behaviour and propogation/response times. For the cases
> its not required and you wan to keep PCI load down then checking first
> is clearly logical.

The 400nS delay isn't the one in the loop.  I was referring to the other 
delay.

Putting the Status register read first will also flush out any posted 
writes, before delaying, and potentially exit more rapidly if the device 
is immediately ready.

	Jeff


