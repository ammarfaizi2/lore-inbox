Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUELW3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUELW3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUELW3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:29:50 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:46813 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261981AbUELW3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:29:47 -0400
Message-ID: <40A2A534.9080004@zytor.com>
Date: Wed, 12 May 2004 15:29:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6-BK] x86_64 has buggy ffs() implementation
References: <1084369416.16624.53.camel@imp.csi.cam.ac.uk> <c7u1js$1h2$1@terminus.zytor.com> <20040512211124.GA6005@iram.es>
In-Reply-To: <20040512211124.GA6005@iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:
> 
> Either I'm asleep or you are emulating bsrl, not bsfl. It
> should rather be:
> 
> 	if ( y & 0x00000001) return 1;
> 	if ( y & 0x00000002) return 2;
> 	if ( y & 0x00000004) return 3;
> 	...
> 	if ( y & 0x80000000) return 32;
> 	return 0;
> 
> No need for the else clauses either because of the return.
> But maybe even __builtin_ffs(y) would work in this case.
> 

If __builtin_ffs() works *AND HAS THE RIGHT SEMANTICS* it's probably the 
best thing to use.

Otherwise, yes, generic_ffs() can clearly be used inside the 
__builtin_constant_p() clause.

	-hpa
