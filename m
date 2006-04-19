Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWDSVgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWDSVgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWDSVgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:36:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751161AbWDSVgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:36:22 -0400
Date: Wed, 19 Apr 2006 14:38:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: mason@suse.com, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [RFC] copy_from_user races with readpage
Message-Id: <20060419143846.7fe9377a.akpm@osdl.org>
In-Reply-To: <20060419134148.262c61cd.akpm@osdl.org>
References: <200604191318.45738.mason@suse.com>
	<20060419134148.262c61cd.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> The application is being a bit silly, because the read will return
> indeterminate results depending on whether it gets there before or after
> the write.  But that's assuming that the read is reading the part of the
> page which the writer is writing.  If the reader is reading bytes 1000-1010
> and the writer is writing bytes 990-1000 then the reader is being non-silly
> and would be justifiably surprised to see zeroes.
> 

No, that's wrong, isn't it?  If the reader is reading parts of the page
which the writer isn't writing then __copy_from_user_inatomic() won't touch
that part of the page.

So it's only the SillyApp which we're dealing with here.

So hrm.  Yes, I guess we should still fix it.
