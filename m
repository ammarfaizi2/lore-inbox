Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSAFQPp>; Sun, 6 Jan 2002 11:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288982AbSAFQPf>; Sun, 6 Jan 2002 11:15:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18180 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288980AbSAFQPV>; Sun, 6 Jan 2002 11:15:21 -0500
Subject: Re: [PATCH]: 2.5.1pre9 change several if (x) BUG to BUG_ON(x)
To: velco@fadata.bg (Momchil Velikov)
Date: Sun, 6 Jan 2002 16:26:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mumismo@wanadoo.es (Jordi),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <878zbba629.fsf@fadata.bg> from "Momchil Velikov" at Jan 06, 2002 04:48:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NG7X-0005gu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan> 	BUG_ON(function(x,y))
> 
> #ifdef DEBUG
> #define BUG_ON(x) if (x) BUG()
> #else
> #define BUG_ON(x) (void)(x)
> #endif

(void)(x) may cause x not be evaluated if the compiler can optimise it out
on the grounds that the result is discarded. Fortunately gcc can't remove
anything that has side effects so providing there are no other bugs in the
code (eg referencing mmio addresses) it should be fine - you are correct
