Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWAEDUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWAEDUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWAEDUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:20:51 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:19027 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751897AbWAEDUu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:20:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OGXeMC21hE5X9ao08KOIjusyIuNfq6ehjyZltTTjK1mFLiOiw4/6o06rLI/gg73gq1CXxqvIAtAZWK1Ie0MN17mmtgydmBTaRQLCYBb/p4AFa/S71YRMNuIvNQhHpGECCsfoTVZl7LxEXu9+Rfw4fFSy9bB+IMHlU74cXhCG4Yo=
Message-ID: <7cd5d4b40601041920u596551d2h75e167311e9452e4@mail.gmail.com>
Date: Thu, 5 Jan 2006 11:20:49 +0800
From: jeff shia <tshxiayu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: what is the state of current after an mm_fault occurs?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060104174808.7b882af8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7cd5d4b40601040240n79b2d654t33424e91059988a9@mail.gmail.com>
	 <20060104174808.7b882af8.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

en,
 You mean in some pagefault place we do schedule()?
  Where?
  Thank you !



On 1/5/06, Andrew Morton <akpm@osdl.org> wrote:
> jeff shia <tshxiayu@gmail.com> wrote:
> >
> >        In my opinion, the state of current should be TASK_RUNNING
> >  after an mm_fault occurs.But I donot know why the function of
> >  handle_mm_fault() set the state of current TASK_RUNNING.
>
> It was a long time ago.. 2.4.early, perhaps.
>
> There was a place (maybe in the select() code) where we were doing
> copy_*_user() while in state TASK_INTERRUPTIBLE.  And iirc there was a
> place in the pagefault code which did schedule().  So we would occasionally
> hit schedule() in state TASK_INTERRUPTIBLE, when we expected to be in state
> TASK_RUNNING.
>
> So we made handle_mm_fault() set TASK_RUNNING to prevent any further such
> things.
>
>
