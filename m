Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUF3BrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUF3BrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 21:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUF3BrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 21:47:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:8678 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266187AbUF3BrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 21:47:17 -0400
Subject: Re: [PATCH] PPC64: lockfix for rtas error log
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linas@austin.ibm.com
Cc: paulus@au1.ibm.com, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040629175007.P21634@forte.austin.ibm.com>
References: <20040629175007.P21634@forte.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1088559864.1906.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 20:44:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-29 at 17:50, linas@austin.ibm.com wrote:
> Paul,
> 
> Could you please apply the following path to the ameslab tree, and/or
> forward it to the main 2.6 kernel maintainers.
> 
> This patch moves the location of a lock in order to protect
> the contents of a buffer until it has been copied to its final
> destination. Prior to this, a race existed whereby the buffer
> could be filled even while it was being emptied.

Hrm....

That's bad, I moved that out of the lock on purpose to avoid deadlocks,
I think ppc_md.log_error can take the rtas lock again (nvram). We need to
take a separate lock for the err buf if that function can be called
concurrently I suppose.

Ben.



