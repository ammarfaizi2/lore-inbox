Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVIWSwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVIWSwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVIWSwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:52:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:4483 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751135AbVIWSwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:52:12 -0400
Date: Sat, 24 Sep 2005 00:16:15 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Pablo Fernandez <pablo.ferlop@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: max_fd
Message-ID: <20050923184615.GB4573@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <8518592505092305373465a5@mail.gmail.com> <20050923155509.GA4723@in.ibm.com> <20050923170345.GA1555@janus> <20050923172653.GA4573@in.ibm.com> <20050923184056.GA2024@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923184056.GA2024@janus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 08:40:56PM +0200, Frank van Maarseveen wrote:
> On Fri, Sep 23, 2005 at 10:56:53PM +0530, Dipankar Sarma wrote:
> > 
> > Well, the main reason is that if that code is somehow copied
> > by to a lock-free critical section, it could cause problems.
> > If you dereference ->fdt multiple times in a lock-free
> > section, you could see two different pointers due to
> > a concurrent update.
> 
> thanks for the explanation. This raises a lot of other questions. What
> if max_fds is updated by RCU right after obtaining it...

If you are updating it, you hold the lock. That way you can't
be racing with another update. Secondly, changing max_fds
would require allocating a new fdtable structure and
updating ->fdt to point to the new structure, all under
the files_struct lock. The lock-free readers may see the
older fdtable which is kept around until the RCU grace
period is over. That makes it safe.

Thanks
Dipankar
