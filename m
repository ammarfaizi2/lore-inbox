Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWJXRG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWJXRG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 13:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWJXRG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 13:06:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49830 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161109AbWJXRG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 13:06:58 -0400
Date: Tue, 24 Oct 2006 18:06:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Chinner <dgc@sgi.com>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, xfs@oss.sgi.com
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061024170633.GA17956@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, David Chinner <dgc@sgi.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>, xfs@oss.sgi.com
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <20061024144446.GD11034@melbourne.sgi.com> <200610241730.00488.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610241730.00488.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 05:29:59PM +0200, Rafael J. Wysocki wrote:
> Do you mean calling sys_sync() after the userspace has been frozen
> may not be sufficient?

No, that's definitly not enough.  You need to freeze_bdev to make sure
data is on disk in the place it's expected by the filesystem without
starting a log recovery.

