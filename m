Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWIKP4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWIKP4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWIKP4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:56:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57804 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964918AbWIKP4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:56:18 -0400
Date: Mon, 11 Sep 2006 12:03:28 -0400
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Rickard Faith <faith@redhat.com>
Subject: Re: [PATCH] fix warning: no return statement in function returning non-void in kernel/audit.c
Message-ID: <20060911160328.GJ4743@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
	Rickard Faith <faith@redhat.com>
References: <200609111715.17080.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609111715.17080.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 05:15:16PM +0200, Jesper Juhl wrote:
 > 
 > kauditd_thread() is being used in a call to kthread_run(). kthread_run() expects
 > a function returning 'int' which is also how kauditd_thread() is declared. Unfortunately
 > kauditd_thread() neglects to return a value which results in this complaint from gcc :
 > 
 >   kernel/audit.c:372: warning: no return statement in function returning non-void
 > 
 > Easily fixed by just adding a 'return 0;' to kauditd_thread().

Which will never be reached.  Does marking the function NORET_TYPE
also silence the warning?

	Dave
