Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVIOFAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVIOFAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 01:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVIOFAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 01:00:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:49596 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965039AbVIOFAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 01:00:41 -0400
Date: Thu, 15 Sep 2005 10:24:40 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
Message-ID: <20050915045440.GE6237@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050914191842.GA6315@in.ibm.com> <20050914.125750.05416211.davem@davemloft.net> <20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net> <43289376.7050205@cosmosbay.com> <20050914220205.GC6237@in.ibm.com> <4328A73B.1080801@cosmosbay.com> <20050914225043.GD6237@in.ibm.com> <4328B013.1010400@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4328B013.1010400@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 01:19:47AM +0200, Eric Dumazet wrote:
> Dipankar Sarma a écrit :
> >On Thu, Sep 15, 2005 at 12:42:03AM +0200, Eric Dumazet wrote:
> >
> >>Dipankar Sarma a écrit :
> 
> >>If yes, the whole embedded struct fdtable is readonly.
> >
> >
> >But not close_on_exec_init or open_fds_init. We would update them
> >on open/close.
> 
> Yes, sure, but those fields are not part of the embedded struct fdtable

Those fdsets would share a cache line with fdt, fdtable which would
be invalidated on open/close. So, what is the point in moving
file_lock ?

Thanks
Dipankar
