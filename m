Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbUBTUqd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUBTUqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:46:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47109 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261313AbUBTUq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:46:27 -0500
Message-ID: <403671FE.8090005@transmeta.com>
Date: Fri, 20 Feb 2004 12:45:50 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: kernel too big
References: <UTC200402201400.i1KE0AH09811.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200402201400.i1KE0AH09811.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> +
> +	if ((is_big_kernel && end && end > 0xc0c00000) ||
> +	    (!is_big_kernel && sys_size > DEF_SYSSIZE)) {


The only issue I see here is that is_big_kernel is actually wrong, the
correct logic should be:


if ((end && end > 0xc0c00000) ||
    (!is_big_kernel && sys_size > DEF_SYSSIZE))

Not that it matters much, but it's correct that way.

I would also feel a lot happier if this was actually defined
symbolically somewhere, and there was a comment connecting it to head.S.

Alternative I could take a stab at making these tables auto-generated
and therefore completely eliminate this dependency for bzImage.

	-hpa

