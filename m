Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWDFB7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDFB7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 21:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWDFB7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 21:59:51 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:33273 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750830AbWDFB7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 21:59:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZR9BS1DZoDn02VQrm/4Y+61VcoLGABxClVCrBLeX4HWTO8MlRFoUY+LZVZY/FtOGE/CztYdgdDZUKjABqMvu/mtXlKHko7AjqQSm0bGbstww6ZjGrBYgRPQ1yiLEJTZQ3hKfbcFfGbaDdJ+XTmSrjOakPN/QBJnn+gKfBRtjWps=
Message-ID: <bda6d13a0604051859l1af5e772n2c1e238694e051ac@mail.gmail.com>
Date: Wed, 5 Apr 2006 18:59:50 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: readers-writers mutex
In-Reply-To: <1144285616.3023.3.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0604051521o229de77dvb38992d6427a450c@mail.gmail.com>
	 <1144285616.3023.3.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2006-04-05 at 15:21 -0700, Joshua Hudson wrote:
> > Since we are moving from semaphores to mutex, there should be a
> > mutex_rw.
>
> should there really? We discussed this briefly during the mutex work
> the conclusion was that rw_sems
> 1) are rare (thankfully; they're highly expensive)
> 2) do not have mutex semantics
>
> so... can you explain how your rw_mutex is behaving different from an
> rw_sem, and can you explain what the gains are for that conversion?
> (eg for mutex it was better defined semantics, lots better debugging
> (possible due to the semantics) and more performance). What is that for
> rw_mutex ?
>
Just this: it inherits the better debugging from mutex. And if a
rw_sem is more expensive than two mutexes, this is cheaper where
it can be used (no ability to downconvert a lock).

Oh, and if nobody uses it, kernel size changes by 0k.
