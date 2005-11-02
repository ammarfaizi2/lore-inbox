Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVKBJuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVKBJuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVKBJuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:50:23 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:60611 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932537AbVKBJuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:50:21 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Notifier chains are unsafe 
In-reply-to: Your message of "Tue, 01 Nov 2005 16:20:43 CDT."
             <Pine.LNX.4.44L0.0511011610470.4473-100000@iolanthe.rowland.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Nov 2005 20:50:11 +1100
Message-ID: <5979.1130925011@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005 16:20:43 -0500 (EST), 
Alan Stern <stern@rowland.harvard.edu> wrote:
>You mean the RCU-style update?  It will hang when a callout routine tries 
>to deregister itself as it is running, although we could add a new 
>unregister_self API to handle that.  Just check for num_callers equal to 1 
>instead of 0.

A callout on an atomic notifer chain has no business calling the
register/unregister functions.  It makes no sense for an atomic context
to call a routine that can sleep or block.

