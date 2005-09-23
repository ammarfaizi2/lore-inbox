Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbVIWVcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbVIWVcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVIWVcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:32:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40617 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751315AbVIWVcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:32:42 -0400
Date: Fri, 23 Sep 2005 14:32:41 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: tty update speed regression (was: 2.6.14-rc2-mm1)
Message-ID: <20050923213241.GB3950@us.ibm.com>
References: <20050921222839.76c53ba1.akpm@osdl.org> <20050922195029.GA6426@mipter.zuzino.mipt.ru> <20050922214926.GA6524@mipter.zuzino.mipt.ru> <20050923000815.GB2973@us.ibm.com> <29495f1d050923101228384a34@mail.gmail.com> <20050923184216.GA6452@mipter.zuzino.mipt.ru> <20050923190749.GO5910@us.ibm.com> <20050923194252.GA6460@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923194252.GA6460@mipter.zuzino.mipt.ru>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2005 [23:42:53 +0400], Alexey Dobriyan wrote:
> On Fri, Sep 23, 2005 at 12:07:49PM -0700, Nishanth Aravamudan wrote:
> > On 23.09.2005 [22:42:16 +0400], Alexey Dobriyan wrote:
> > > poll([{fd=0, events=POLLIN}], 1, 0) = 0
> 
> > > I can send full strace log if needed.
> > 
> > Nope, that helped tremendously! I think I know what the issue is (and
> > why it's HZ dependent).
> > 
> > In the current code, (2.6.13.2, e.g) we allow 0 timeout poll-requests to
> > be resolved as 0 jiffy requests. But in my patch, those requests become
> > 1 jiffy (which of course depends on HZ and gets quite long if HZ=100)!
> > 
> > Care to try the following patch?
> 
> It works! Now, even with HZ=100, gameplay is smooth.
> 
> Andrew, please, apply.

Great! Thanks for the testing, Alexey.

-Nish
