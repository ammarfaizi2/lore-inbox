Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVHON1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVHON1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 09:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVHON1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 09:27:31 -0400
Received: from [81.2.110.250] ([81.2.110.250]:8584 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932445AbVHON1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 09:27:30 -0400
Subject: Re: [-mm patch] make kcalloc() a static inline
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Arjan van de Ven <arjan@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0508151601540.3068@sbz-30.cs.Helsinki.FI>
References: <20050808223842.GM4006@stusta.de>
	 <200508151233.46523.vda@ilport.com.ua>
	 <1124098918.3228.25.camel@laptopd505.fenrus.org>
	 <200508151517.52171.vda@ilport.com.ua>
	 <1124108737.3228.35.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0508151601540.3068@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Aug 2005 14:51:13 +0100
Message-Id: <1124113874.4437.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-15 at 16:06 +0300, Pekka J Enberg wrote:
> and  I saw small reduction in kernel text with kcalloc() inlined. If GCC 
> is, in fact, spreading the extra operations everywhere, shouldn't kernel 
> text be bigger?

Only if the cost of the function call in lines of code is higher than
the inline code. That includes the less obvious cost for the fact that
its a synchronization point so you can't do certain optimisations
through a function call (the function you are calling may read/write any
global/static variable or pointer target).

Alan

