Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbWJKSSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbWJKSSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWJKSSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:18:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161174AbWJKSSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:18:02 -0400
Date: Wed, 11 Oct 2006 11:17:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1-mm1] Export jiffies_to_timespec()
Message-Id: <20061011111739.09c25a8e.akpm@osdl.org>
In-Reply-To: <20061011161628.GA1873@infradead.org>
References: <452C3CA6.2060403@goop.org>
	<20061011161628.GA1873@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 17:16:28 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Oct 10, 2006 at 05:36:54PM -0700, Jeremy Fitzhardinge wrote:
> > Export jiffies_to_timespec; previously modules used the inlined header 
> > version.
> 
> NACK, drivers shouldn know about these timekeeping details and no
> in-tree driver uses it (fortunately)

Disagree.

a) `jiffies' and `timepsec' are hardly "details".  They are basic
   kernel-wide concepts.  timespecs are even known to userspace.  Exporting
   a helper function which converts from one to the other is perfectly
   reasonable.

b) jiffies_to_timespec() was previously available to modules.  We
   changed that without notice and we changed it *by accident*.  There was
   no intention to withdraw jiffies_to_timespec() from the
   available-to-modules API.


If we really wanted to withdraw jiffies_to_timespec() then we'd mark it
__deprecated_for_modules for a while, then withdraw it.  But there's no
earthly reason why we'd want to withdraw it: the export makes sense.
