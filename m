Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbTFSFcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 01:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbTFSFcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 01:32:04 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:7586 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265085AbTFSFcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 01:32:03 -0400
Date: Wed, 18 Jun 2003 22:46:56 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg Norris <haphazard@kc.rr.com>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Solarz-Niesluchowski 
	<B.Solarz-Niesluchowski@wsisiz.edu.pl>
Subject: Re: 2.5.72 oops (scheduling while atomic)
Message-Id: <20030618224656.0f5639bb.akpm@digeo.com>
In-Reply-To: <20030617143551.GA3057@glitch.localdomain>
References: <20030617143551.GA3057@glitch.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 05:46:01.0344 (UTC) FILETIME=[10B4B000:01C33626]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Norris <haphazard@kc.rr.com> wrote:
>
> I'm getting the following oops when booting 2.5.72, preceded by a
>  quite a few "bad: scheduling while atomic!" messages.  My .config and
>  the decoded oops are attached.

I was able to reproduce this.  Pid #0 (swapper) ends up with a preempt
count of two and everything goes pear-shaped.

This appears to be because you haven't selected any chip drivers in IDE
config.  I selected PIIX and things started working better.

Just to double-check I took my usual .config, enable preemption, disabled
all IDE chip drivers and the same thing happened.  Over to Bart ;)


Your .config seems broken in other ways btw.  Suggest you do 

	cp arch/i386/defconfig .config

and start again.

