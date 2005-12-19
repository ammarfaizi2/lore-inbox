Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbVLSGmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbVLSGmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 01:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbVLSGmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 01:42:05 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:18300 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965235AbVLSGmE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 01:42:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZfCFPDirDWalXS2jIcwaBTBPFCvtUKgn8kZV+sca8wqmSqdAc4qxTqyivgetneoFS326VhxGhOSZbjANULKbD/L/EPxTKlg7LvFmVaWm8+q4ZctYdUeHCSlg43/3Uc98kigWGEake62N04UGj/srv0uc+1QTSvJ77GlxMuaIszA=
Message-ID: <f0309ff0512182242u59bd4583o37da5a8552739e5a@mail.gmail.com>
Date: Sun, 18 Dec 2005 22:42:02 -0800
From: Nauman Tahir <nauman.tahir@gmail.com>
To: Hua Feijun <hua.feijun@gmail.com>
Subject: Re: stop threads failed!
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3fe1d240512181717h59100c1h@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3fe1d240512170057h2a1e0929o@mail.gmail.com>
	 <f0309ff0512180036q179b9f12n16609f86743c1b9c@mail.gmail.com>
	 <3fe1d240512181717h59100c1h@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/05, Hua Feijun <hua.feijun@gmail.com> wrote:
> Sorry, I couldn't describe the problem clearly.I means these threads
> did not go to sleep'in fact, they didn't stop runing.
>

Kindly also CC this to linux-kernel as well so that you have more
chances to get the solution of your problem.
It seems to me that you may have missed SIG_PENDING at the time when
you setup your thread. You will have to signal your thread to kill it.
Just setting up TASK STATE is not enough untill the process gets
scheduled or it gets the signal to kill itself explicitly


> 2005/12/18, Nauman Tahir <nauman.tahir@gmail.com>:
> > On 12/17/05, Hua Feijun <hua.feijun@gmail.com> wrote:
> > > I want to set threads's status to TASK_STOPPED by the following
> > > code.The syslog has show this rourine has been executed,buf the thread
> > > is still running.Who can tell me the reason?Thanks very much!
> > > write_lock(&tasklist_lock);
> > > do
> > > {
> > > printk("set threads stopped\n");
> > > p->state = TASK_STOPPED;
> > > } while ((p = next_thread(p)) != leader);
> > > write_unlock(&tasklist_lock);
> > > schedule();
> > > -
> >
> > Have you specified the state TASK_INTERRUPTIBLE when you wake up the
> > thread? If not then do it to ba able to stop it later.
> > Anybody else correct me if I am wrong please
