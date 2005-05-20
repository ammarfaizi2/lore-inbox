Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVETNdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVETNdY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVETNdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:33:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40173 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261382AbVETNdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:33:14 -0400
Date: Fri, 20 May 2005 14:33:38 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] vfs: increase scope of critical locked path in fget_light to avoid race
Message-ID: <20050520133337.GP29811@parcelfarce.linux.theplanet.co.uk>
References: <20050520132325.GE19229@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520132325.GE19229@hmsendeavour.rdu.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 09:23:25AM -0400, Neil Horman wrote:
> Patch to increase the scope of the locked critical path in fget_light to include
> the conditional where there is only one reference to the passed file_struct.
> Currently there is no protection against someone modifying that reference count
> after it has been read in fget_light and falling into a code path where the fd
> array is modified.  The result is a race condition that leads to a corrupted fd
> table and potential oopses.  This patch corrects that by enforcing the locking
> protocol that is used by all other accessors of the fd table on the 1 reference
> case in fget_light.  Smoke tested by me, with no failures.

Er...  If we get 1, we *KNOW* who holds the only reference - that's us.
And to change refcount of files_struct you need to hold a reference to
it.

Do you have a full race scenario?  With all participants spelled out, please.
