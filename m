Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWJ1QuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWJ1QuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWJ1QuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 12:50:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12741 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751061AbWJ1QuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 12:50:16 -0400
Date: Sat, 28 Oct 2006 17:50:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1-mm1] Export jiffies_to_timespec()
Message-ID: <20061028165002.GB22673@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	john stultz <johnstul@us.ibm.com>
References: <452C3CA6.2060403@goop.org> <20061011161628.GA1873@infradead.org> <20061011111739.09c25a8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011111739.09c25a8e.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 11:17:39AM -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2006 17:16:28 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > On Tue, Oct 10, 2006 at 05:36:54PM -0700, Jeremy Fitzhardinge wrote:
> > > Export jiffies_to_timespec; previously modules used the inlined header 
> > > version.
> > 
> > NACK, drivers shouldn know about these timekeeping details and no
> > in-tree driver uses it (fortunately)
> 
> Disagree.
> 
> a) `jiffies' and `timepsec' are hardly "details".  They are basic
>    kernel-wide concepts.  timespecs are even known to userspace.  Exporting
>    a helper function which converts from one to the other is perfectly
>    reasonable.

That non one in tree ever uses it is a very good reason no to export it
either.  While there are still far too many direct jiffy users there
is no one directly convertin it to a timespec for good reason.

> 
> b) jiffies_to_timespec() was previously available to modules.  We
>    changed that without notice and we changed it *by accident*.  There was
>    no intention to withdraw jiffies_to_timespec() from the
>    available-to-modules API.

By that rationale everything errornously implemented as a macro or inline
at some point will need to be exported.  Except for you we still maintain
that we don't want to keep unused exports.  Arjan even put a formal mechanism
in to warn about them and has gotten a global buy-in to kill them.  This
will fall under this ASAP and only give people a short period to keep using
it.  Not a very useful message.

(especially when the only user is closed source crap where people should
help the proper reverse-engineered driver instead)

