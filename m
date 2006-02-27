Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWB0JNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWB0JNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbWB0JNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:13:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4834 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751126AbWB0JNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:13:18 -0500
Subject: Re: [Patch 4/7] Add sysctl for delay accounting
From: Arjan van de Ven <arjan@infradead.org>
To: dipankar@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <20060227090414.GA18941@in.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141028322.5785.60.camel@elinux04.optonline.net>
	 <1141028784.2992.58.camel@laptopd505.fenrus.org>
	 <4402BA93.5010302@watson.ibm.com>
	 <1141029743.2992.71.camel@laptopd505.fenrus.org>
	 <20060227090414.GA18941@in.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 10:13:14 +0100
Message-Id: <1141031595.2992.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 14:34 +0530, Dipankar Sarma wrote:
> On Mon, Feb 27, 2006 at 09:42:23AM +0100, Arjan van de Ven wrote:
> > On Mon, 2006-02-27 at 03:38 -0500, Shailabh Nagar wrote:
> > > Arjan van de Ven wrote:
> > > 
> > > The function needs to allocate task_delay_info structs for all tasks 
> > > that might
> > > have been forked since the last time delay accounting was turned off.
> > > Either we have to count how many such tasks there are, or preallocate
> > > nr_tasks (as an upper bound) and then use as many as needed.
> > 
> > it generally feels really fragile, especially with the task enumeration
> > going to RCU soon. (eg you'd lose the ability to lock out new task
> > creation)
> 
> I haven't yet seen any RCU-based code that does this. Can you point out
> what patches you are talking about ? As of 2.6.16-rc4 and -rt15,
> AFAICS, you can count tasks by holding the read side of tasklist_lock.
> Granted it is a bit ugly to repeat this in order to overcome
> the race on dropping tasklist_lock for allocation.

there are several people (Christoph for one) who are working on making
the tasklist_lock go away entirely in favor of RCU-like locking...

