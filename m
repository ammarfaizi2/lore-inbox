Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTEYLyD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTEYLyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:54:03 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:49931 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262033AbTEYLyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:54:01 -0400
Date: Sun, 25 May 2003 13:07:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Paulo Andre'" <l16083@alunos.uevora.pt>
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Question on verify_area() and friends wrt
Message-ID: <20030525130706.B9127@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paulo Andre' <l16083@alunos.uevora.pt>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030525124625.4dedc758.l16083@alunos.uevora.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030525124625.4dedc758.l16083@alunos.uevora.pt>; from l16083@alunos.uevora.pt on Sun, May 25, 2003 at 12:46:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 12:46:25PM +0100, Paulo Andre' wrote:
> if (!verify_area(VERIFY_WRITE, ptr, sizeof(ir) +
> 		(sizeof(struct inquiry_info) * ir.num_rsp))) {
>     copy_to_user(ptr, &ir, sizeof(ir));
>     ptr += sizeof(ir);
>     copy_to_user(ptr, buf, sizeof(struct inquiry_info) * ir.num_rsp);	} else
>     err = -EFAULT;
> 
> I'm presuming verify_area() does its job fine returning 0 if the memory
> is valid and -EFAULT if not. Thus, given the exact check that's been
> done, there seems indeed to exist no need to check each call to
> copy_to_user() below. Or is there?

verify_area only does some checks so you need to check the return value
from copy_to_user.  You could switch to __copy_to_user, though.

