Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWB1PCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWB1PCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWB1PCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:02:47 -0500
Received: from 32.red-82-159-197.user.auna.net ([82.159.197.32]:56034 "EHLO
	indy.cmartin.tk") by vger.kernel.org with ESMTP id S932113AbWB1PCr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:02:47 -0500
From: Carlos =?utf-8?q?Mart=C3=ADn?= <carlos@cmartin.tk>
To: Kurt Garloff <garloff@suse.de>
Subject: Re: [PATCH] OOM: initialise points variable in out_of_memory()
Date: Tue, 28 Feb 2006 16:05:03 +0100
User-Agent: KMail/1.9.1
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>
References: <11410761851547-git-send-email-carlos@cmartin.tk> <20060228121303.GE6641@tpkurt.garloff.de>
In-Reply-To: <20060228121303.GE6641@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602281605.03845.carlos@cmartin.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 13:13, Kurt Garloff wrote:
> Hi Carlos,
> 
> On Mon, Feb 27, 2006 at 10:36:25PM +0100, Carlos Martin wrote:
> > We didn't initialise points, so the value reported was completely
> > random. This doesn't affect the behaviour of the funcion.
> 
> Did you observe it?

No. GCC complained about it.

> 
> In the original patch, there is 
> +static struct task_struct * select_bad_process(unsigned long *ppoints)
>  {
> -       unsigned long maxpoints = 0;
>         struct task_struct *g, *p;
>         struct task_struct *chosen = NULL;
>         struct timespec uptime;
> +       *ppoints = 0;
> 
> And this is called from out_of_memory().
> 
> But the constrained_alloc stuff seems to use points before 
> select_bad_process() is called, so initializing to 0 is a
> good idea. I don't remember having see the constrained_alloc
> stuff, though, so I either did not look carefully enough or a 
> merge error happened afterwards. 

It never used to be a problem because it was initialised when calling 
select_bad_process().

I though it was your change, but I've looked again and it was Christoph 
Lameter's commit 9b0f8b040acd8dfd23860754c0d09ff4f44e2cbc which introduced 
the problem.

   cmn
-- 
Carlos Martín Nieto    |   http://www.cmartin.tk
Hobbyist programmer    |
