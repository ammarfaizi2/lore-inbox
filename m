Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbTICE2H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 00:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTICE2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 00:28:07 -0400
Received: from paiol.terra.com.br ([200.176.3.18]:8352 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP id S261679AbTICE2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 00:28:05 -0400
Message-ID: <3F556DD1.2070707@terra.com.br>
Date: Wed, 03 Sep 2003 01:28:01 -0300
From: Marcelo Abreu <skewer@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Insert a Propreitary Encapsulation module to PPP
References: <01C3713C.0DACA2E0.vanitha@agilis.st.com.sg>
In-Reply-To: <01C3713C.0DACA2E0.vanitha@agilis.st.com.sg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vanitha wrote:
> I want to insert a module which will add a proprietary encapsulation header
> (specific to our systems) and then send out the ppp packet over serial
> interface (it will either be a High speed serial interface or a V.35
> interface).

	You could create a new module based on hdlc_ppp.c, changing the
following line in hdlc_ppp_ioctl():

dev->hard_start_xmit = hdlc->xmit;

	to:

dev->hard_start_xmit = my_new_xmit;

	Then you implement my_new_xmit() that adds the encapsulation and
calls hdlc->xmit() at the end.

	See also hdlc_raw_eth.c on 2.6. It does exactly this.


	Marcelo

