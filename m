Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272902AbTHEQqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272916AbTHEQqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:46:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19173 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272902AbTHEQqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:46:45 -0400
Date: Tue, 5 Aug 2003 17:46:43 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Jesse Pollard <jesse@cats-chateau.net>, beepy@netapp.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030805164642.GE12757@parcelfarce.linux.theplanet.co.uk>
References: <20030804134415.GA4454@win.tue.nl> <200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com> <20030804175609.7301d075.skraw@ithnet.com> <03080416295003.04444@tabby> <20030805014244.0a71f6c9.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805014244.0a71f6c9.skraw@ithnet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Egads...  OK, here comes:
	a) if you have real loops in directory graph (directory being
its own descendent), determining whether rename() will make it disconnected
becomes hell; it's completely infeasible.
	b) if you allow multiple paths from root, preventing loops creation
upon rename() also becomes hell.

	Forget about VFS, on-disk structures, etc. - just think in terms
of oriented graphs and operations on them; that's the price you'd have
to pay with any implementation and it's *big*.
