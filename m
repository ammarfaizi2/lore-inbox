Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVLPTCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVLPTCO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVLPTCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:02:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59607 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932377AbVLPTCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:02:13 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43A30D36.5090406@didntduck.org>
References: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
	 <43A30D36.5090406@didntduck.org>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 20:02:10 +0100
Message-Id: <1134759731.2992.57.camel@laptopd505.fenrus.org>
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


> 
> So what about arches where single-page stacks aren't viable (for example 
> x86_64)?  Are we just screwed?


x86 is specially handicapped due to the fact that the stacks need to be
in the lowmem zone. Even if you have 8Gb ram, the lowmem zone is still
800Mb and a bit, and this gets to be under a high pressure, like
hyper-fragmentation. Same for bounce buffers etc etc.

note that the order thing is by far not the only advantage, pure memory
usage alone and cache locality also are wins. The memory usage halves
for kernel stacks after all (which means you can do more threads in
java, or use the memory for disk cache ;)

