Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVDEKBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVDEKBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDEJu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:50:28 -0400
Received: from ozlabs.org ([203.10.76.45]:27805 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261628AbVDEJon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:44:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16978.24070.786761.641930@cargo.ozlabs.ibm.com>
Date: Tue, 5 Apr 2005 19:44:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
In-Reply-To: <20050405093020.GA28620@infradead.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405074405.GE26208@infradead.org>
	<21d7e99705040502073dfa5e5@mail.gmail.com>
	<16978.22617.338768.775203@cargo.ozlabs.ibm.com>
	<20050405093020.GA28620@infradead.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

>  - the magic CONFIG_COMPAT changes for SHM handles should only be done when
>    a module is set.  CONFIG_COMPAT is set for mostly 64bit systems that can
>    run 32bit code and drm shouldn't behave differently just because we can
>    run 32bit code.

Yes it should - we can have a 64-bit X server and a 32-bit DRI
client.  In this case the server will allocate a _DRM_SHM area and
pass the handle to the client, which will then try to mmap the area.
If we give a 64-bit handle to the server the client won't be able to
access the area.

Paul.
