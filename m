Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUK3Rs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUK3Rs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUK3Rs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:48:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29358 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262213AbUK3RsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:48:23 -0500
Message-ID: <41ACB253.9090202@pobox.com>
Date: Tue, 30 Nov 2004 12:48:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 6/6] s390: qeth network driver.
References: <20041130151013.GG4758@mschwid3.boeblingen.de.ibm.com>
In-Reply-To: <20041130151013.GG4758@mschwid3.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> @@ -1308,6 +1326,15 @@
>  			continue;
>  		if (ipaddr->type != QETH_IP_TYPE_RXIP)
>  			continue;
> +		/* String must not be longer than PAGE_SIZE. So we check for
> +		 * length >= 3900 here. Then we can savely display the next
> +		 * IPv6 address and our info message below */
> +		if (i >= 3900) {
> +			i += sprintf(buf + i,
> +				     "... Too many entries to be displayed. "
> +				     "Skipping remaining entries.\n");
> +			break;
> +		}


ACK, although I dislike the open-coding of the magic number 3900.

3900 strikes me as an engineer's guess, not a rigorous limit on strings, 
thus inviting the possibility of a buffer overflow years later.

	Jeff


