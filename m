Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWDYCsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWDYCsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 22:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWDYCsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 22:48:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751351AbWDYCsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 22:48:24 -0400
Date: Mon, 24 Apr 2006 19:47:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: sekharan@us.ibm.com
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu
Subject: Re: [PATCH 3/3] Assert notifier_block and notifier_call are not in
 init section
In-Reply-To: <20060425023527.7529.9096.sendpatchset@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604241945570.3701@g5.osdl.org>
References: <20060425023509.7529.84752.sendpatchset@localhost.localdomain>
 <20060425023527.7529.9096.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Apr 2006, sekharan@us.ibm.com wrote:
> 
> 	Feel free to drop this patch if you think it is not needed.

It's incorrect.

The init section will be free'd, and as a result can be re-allocated to 
other uses. Thus testing that data is not in the init-section makes no 
sense.

Testing for _code_ not being in the init section can be sensible, since 
code never gets re-allocated (modulo module code, but that's never in the 
init section). So checking the "notifier_call" part may be sensible, but 
checking the notifier block data pointer definitely is not.

Patches 1-2 applied.

		Linus
