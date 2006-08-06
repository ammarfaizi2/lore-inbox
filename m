Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWHFE0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWHFE0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 00:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWHFE0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 00:26:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:60107 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751527AbWHFE0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 00:26:05 -0400
Date: Sat, 5 Aug 2006 23:25:49 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -mm] fs.h: ifdef security fields
Message-ID: <20060806042549.GA3999@sergelap.austin.ibm.com>
References: <20060806023806.GA13480@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806023806.GA13480@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexey Dobriyan (adobriyan@gmail.com):
> [BSD security levels are deleted in -mm, assuming this below]
> 
> The only user of i_security, f_security, s_security fields is SELinux,
> so ifdef them with CONFIG_SECURITY_SELINUX. Following Stephen Smalley's

The SLIM security module, which is trying to get upstream, uses at least
i_security and f_security.

The Argus module supposedly being submitted "soon" which is used in
their LSPP product, surely must use them all.

Maybe you still want to make these CONFIG_SECURITY_SELINUX until the
other modules are upstreamed, but I just wanted to make sure you knew
other modules, trying to get upstream, are using them.

Personally I'd say these are a core part of the LSM framework, and if
you don't want LSM, compile it out.  But since I realize that using only
capabilities must be a pretty common case, how about just adding a
config option CONFIG_SECURITY_OBJFIELDS, which is auto-enabled with
SELINUX and default off, which hides these fields instead?

Patch should be trivial, and I can aim to send one tomorrow.

-serge
