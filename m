Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSIWWJH>; Mon, 23 Sep 2002 18:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbSIWWJH>; Mon, 23 Sep 2002 18:09:07 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37645
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261511AbSIWWJG>; Mon, 23 Sep 2002 18:09:06 -0400
Subject: Re: [PATCH] 32bit wraps and USER_HZ [64 bit counters], kernel
	2.5.37
From: Robert Love <rml@tech9.net>
To: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200209232208.g8NM8bN05831@fokkensr.vertis.nl>
References: <200209222207.g8MM7MM04998@fokkensr.vertis.nl>
	 <20020923023655.GV3530@holomorphy.com>
	 <200209232208.g8NM8bN05831@fokkensr.vertis.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1032819194.25745.241.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 23 Sep 2002 18:13:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-23 at 18:08, Rolf Fokkens wrote:

> On Monday 23 September 2002 04:36, William Lee Irwin III wrote:
>
> > -	unsigned long utime, stime, cutime, cstime;
> > -	unsigned long start_time;
> > -	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
> >
> > Hmm. Isn't task_t bloated enough already? I'd rather remove them than
> > make them 64-bit.
> 
> Since nobody else asks this question:
> 
> Do you mean to leave out process statistics?

Yes, I think he does.

Having arrays statically created at NR_CPUS inside the task_struct is
just gross.  Especially with NR_CPUS=32.  That is 128 bytes each!  Now
with your changes, it is 256 bytes each!

Sacrifice them to the gods of bloat.

	Robert Love

