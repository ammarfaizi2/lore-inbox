Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbTECDqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 23:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263249AbTECDqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 23:46:31 -0400
Received: from [12.47.58.20] ([12.47.58.20]:16337 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263246AbTECDqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 23:46:30 -0400
Date: Fri, 2 May 2003 21:00:03 -0700
From: Andrew Morton <akpm@digeo.com>
To: dipankar@in.ibm.com
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reducing overheads in fget/fput
Message-Id: <20030502210003.7ab96802.akpm@digeo.com>
In-Reply-To: <20030503035300.GA1407@in.ibm.com>
References: <20030428165240.GA1105@in.ibm.com>
	<20030428193228.GP10374@parcelfarce.linux.theplanet.co.uk>
	<20030428195836.GD1105@in.ibm.com>
	<20030502171726.GA1414@in.ibm.com>
	<20030502135404.0ba2ca66.akpm@digeo.com>
	<20030503035300.GA1407@in.ibm.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 May 2003 03:58:51.0518 (UTC) FILETIME=[4ED0D9E0:01C31128]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> On Fri, May 02, 2003 at 01:54:04PM -0700, Andrew Morton wrote:
> > Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > > Here is a patch that fixes that.
> > 
> > This patch is fairly foul.
> 
> Not sure what your grouse is, but I don't like the fget_ligth()/fput_light
> semantics myself. They don't seem natural, but I can't think of
> better way to do this. 

Precisely.

> > 
> > > kernel           sys time     std-dev
> > > ------------     --------     -------
> > > UP - vanilla     2.104        0.028
> > > SMP - vanilla    2.976        0.023
> > > UP - file        1.867        0.019
> > > SMP - file       2.719        0.026
> > 
> > But it is localised, and makes a substantial difference.
> 
> If I haven't broken too many things, then I will try to get some
> performance results from large machines.

P4's will like it more.
 
> > 
> > I inlined fput_light:
> 
> Looks good.

I also renamed `flag' to `fput_needed' everywhere.

