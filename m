Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbUASRWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbUASRWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:22:10 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:64998 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265438AbUASRWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:22:06 -0500
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
From: James Bottomley <James.Bottomley@steeleye.com>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
In-Reply-To: <400BDC85.8040907@wanadoo.es>
References: <400BDC85.8040907@wanadoo.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Jan 2004 12:21:50 -0500
Message-Id: <1074532919.1895.32.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-19 at 08:32, Xose Vazquez Perez wrote:
> It looks like the _kernel_ driver is going to be without a maintainer
> unless somebody works on it, porting ADAPTEC fixes/features to the kernel driver.

As I told you in private email, this is *not* the way I see it.  At the
moment, Ataptec is the maintainer of that driver unless they choose
formally to relinquish it.

There is a glimmering of a resolution of the problem in an early
notification API for command timeouts.

Although throwing away successful completions when error recovery is in
progress isn't a bug (scsi commands are either idempotent or non
retryable), it's certainly not ideal.  I'm thinking about a better
framework where we would quiesce the device but pull back from
activating the eh thread if all commands return.  This would also fix
the tag starvation issue that many drivers tackle independently too.

James


