Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUK3S6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUK3S6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUK3S43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:56:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64925 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262265AbUK3Syy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:54:54 -0500
Subject: Re: [patch 6/6] s390: qeth network driver.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41ACB253.9090202@pobox.com>
References: <20041130151013.GG4758@mschwid3.boeblingen.de.ibm.com>
	 <41ACB253.9090202@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101837055.25617.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 17:50:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 17:48, Jeff Garzik wrote:
> > +		/* String must not be longer than PAGE_SIZE. So we check for
> > +		 * length >= 3900 here. Then we can savely display the next
> > +		 * IPv6 address and our info message below */
> > +		if (i >= 3900) {
> > +			i += sprintf(buf + i,
> > +				     "... Too many entries to be displayed. "
> > +				     "Skipping remaining entries.\n");
> > +			break;
> > +		}
> 
> 
> ACK, although I dislike the open-coding of the magic number 3900.

Use snprintf and the problem goes away I think
	
	static char *errorstring = "...  "

	errorlen = strlen(errorstring);

	If(i < PAGE_SIZE - errorlen)
		i += snprintf(buf + i, PAGE_SIZE - i, ...)
	else {
		memcpy(buf+i, errorstring, errorlen);
		i += errorlen;
		break;
	}
