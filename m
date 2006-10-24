Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbWJXIVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWJXIVn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWJXIVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:21:42 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:12979 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965081AbWJXIVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:21:41 -0400
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610240957.38965.rjw@sisk.pl>
References: <1161576735.3466.7.camel@nigel.suspend2.net>
	 <200610232119.25373.rjw@sisk.pl>
	 <1161643965.7033.12.camel@nigel.suspend2.net>
	 <200610240957.38965.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 18:21:38 +1000
Message-Id: <1161678098.7033.48.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-10-24 at 09:57 +0200, Rafael J. Wysocki wrote:
> > There's no memory leak. In Suspend2 (and I believe swsusp, but will
> > admit I haven't carefully checked), every call to freeze processes has a
> > matching call to thaw them. The thaw call will invoke make_fses_rw,
> > which will free the memory that was allocated. If there's an issue, it's
> > that in the failure path thaw_bdev can be called when freeze_bdev was
> > never invoked. Having just realised that, I've just fixed it.
> 
> I was talking about the leak in the error path, where you exit the function
> without freeing the already allocated objects.

I know. I'm saying that there's no memory leak because any frozen bdevs
(and memory allocated to record them) are unfrozen (and the memory
freed) when we thaw processes before returning control to the user.

Regards,

Nigel

