Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWADUJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWADUJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWADUJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:09:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48512 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751293AbWADUJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:09:45 -0500
Subject: Re: [Patch 2.6] dm-crypt: zero key before freeing it
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Rompf <stefan@loplof.de>
Cc: Andrew Morton <akpm@osdl.org>, Clemens Fruhwirth <clemens@endorphin.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <200601042108.04544.stefan@loplof.de>
References: <200601042108.04544.stefan@loplof.de>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 21:09:39 +0100
Message-Id: <1136405379.2839.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 21:08 +0100, Stefan Rompf wrote:
> Hi Andrew,
> 
> dm-crypt does not clear struct crypt_config before freeing it. Thus, 
> information on the key could leak f.e. to a swsusp image even after the 
> encrypted device has been removed. The attached patch against 2.6.14 / 2.6.15 
> fixes it.

since a memset right before a free is a very unusual code pattern in the
kernel it may well be worth putting a short comment around it to prevent
someone later removing it as "optimization"


