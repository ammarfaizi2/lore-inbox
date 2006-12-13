Return-Path: <linux-kernel-owner+w=401wt.eu-S932618AbWLMIez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbWLMIez (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 03:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWLMIez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 03:34:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54489 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932618AbWLMIey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 03:34:54 -0500
Subject: Re: 2.6.18.4: flush_workqueue calls mutex_lock in interrupt
	environment
From: Arjan van de Ven <arjan@infradead.org>
To: xb <xavier.bru@bull.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457FAAFD.6000300@bull.net>
References: <457FAAFD.6000300@bull.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 13 Dec 2006 09:02:27 +0100
Message-Id: <1165996947.27217.725.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 08:25 +0100, xb wrote:
> Hi all,
> 
> Running some IO stress tests on a 8*ways IA64 platform, we got:
>      BUG: warning at kernel/mutex.c:132/__mutex_lock_common()  message
> followed by:
>      Unable to handle kernel paging request at virtual address
> 0000000000200200
> oops corresponding to anon_vma_unlink() calling list_del() on a
> poisonned list.
> 
> Having a look to the stack, we see that flush_workqueue() calls
> mutex_lock() with softirqs disabled.

something is wrong here... flush_workqueue() is a sleeping function and
is not allowed to be called in such a context!


