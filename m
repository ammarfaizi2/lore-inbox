Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVARWst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVARWst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVARWss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:48:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:61129 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261466AbVARWsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:48:02 -0500
Date: Tue, 18 Jan 2005 14:47:53 -0800
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] tpm: fix cause of SMP stack traces
Message-ID: <20050118224753.GA17547@kroah.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com> <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com> <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com> <29495f1d041221085144b08901@mail.gmail.com> <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com> <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com> <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 04:29:23PM -0600, Kylene Hall wrote:
> There were misplaced spinlock acquires and releases in the probe, open, 
> close and release paths which were causing might_sleep and schedule while 
> atomic error messages accompanied by stack traces when the kernel was 
> compiled with SMP support. Bug reported by Reben Jenster 
> <ruben@hotheads.de>

Where exactly where the trace errors coming from?  I don't see anything
in the open path that might have caused it.

Anyway, Chris is right, just changing this to _irqsave will not fix the
issue.

thanks,

greg k-h
