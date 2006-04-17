Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWDQQXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWDQQXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDQQXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:23:51 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38301 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751140AbWDQQXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:23:50 -0400
Date: Mon, 17 Apr 2006 17:23:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060417162345.GA9609@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
	linux-security-module@vger.kernel.org,
	James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
	fireflier-devel@lists.sourceforge.net
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 12:06:53PM -0400, Stephen Smalley wrote:
> > I thought of this, see label_all_processes. Unfortunately I found no way of 
> > actually doing this. I would need to iterate through the tasklist structure, 
> > but the task_lock export is going to be removed from the kernel.
> 
> So, if built-in isn't an option, propose an interface to the core
> security framework to allow security modules to perform such
> initialization without needing to directly touch the lock themselves

NACK.  The whole idea of loading security modules after bootup is flawed.
Any scheme that tries to enumerate process and other entinity after the
fact for access control purposes is fundamentally flawed.  We're not going
to add helpers or exports for it, I'd rather remove the ability to build
lsm hook clients modular completely.

