Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWB0IhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWB0IhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWB0IhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:37:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20394 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932305AbWB0IhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:37:20 -0500
Subject: Re: [Patch 1/7] timespec diff utility
From: Arjan van de Ven <arjan@infradead.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <4402B994.3000909@watson.ibm.com>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141027367.5785.42.camel@elinux04.optonline.net>
	 <1141028554.2992.53.camel@laptopd505.fenrus.org>
	 <4402B994.3000909@watson.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:37:17 +0100
Message-Id: <1141029438.2992.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 03:34 -0500, Shailabh Nagar wrote:
> Arjan van de Ven wrote:
> 
> >>+/*
> >>+ * timespec_diff_ns - Return difference of two timestamps in nanoseconds
> >>+ * In the rare case of @end being earlier than @start, return zero
> >>+ */
> >>+static inline nsec_t timespec_diff_ns(struct timespec *start, struct timespec *end)
> >>+{
> >>+	nsec_t ret;
> >>+
> >>+	ret = (nsec_t)(end->tv_sec - start->tv_sec)*NSEC_PER_SEC;
> >>+	ret += (nsec_t)(end->tv_nsec - start->tv_nsec);
> >>+	if (ret < 0)
> >>+ 		return 0;
> >>+	return ret;
> >>+}
> >> #endif /* __KERNEL__ */
> >> 
> >>    
> >>
> >
> >wouldn't it be more useful to have this return a timespec as well, and
> >then it'd be generically useful (and it also probably should then be
> >uninlined ;)
> >  
> >
> Return another timespec to store the difference of two input timespecs ? 
> Would that be useful ?
> Didn't quite get it.

the API is a bit crooked right now; you have 2 timespecs as a measure of
time, and you return a long as diff, rather than another timespec.
How do you know the nsec_t doesn't overflow ??? I suspect the answer is
"you don't". timespec's are a way to deal with that nicely. And it makes
the API more symmetric as well

