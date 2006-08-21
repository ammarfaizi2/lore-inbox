Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWHUMoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWHUMoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWHUMoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:44:16 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:56551 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S965080AbWHUMoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:44:14 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Date: Mon, 21 Aug 2006 14:04:15 +0200
User-Agent: KMail/1.8.2
Cc: netdev <netdev@vger.kernel.org>, Thomas Klein <tklein@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcus Eder <meder@de.ibm.com>
References: <44D99F1A.4080905@de.ibm.com> <20060811211915.GL3233@localdomain>
In-Reply-To: <20060811211915.GL3233@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211404.16122.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

sorry for the delayed answer.

On Friday 11 August 2006 23:19, Nathan Lynch wrote:
> > +static inline long ehea_hcall_9arg_9ret(unsigned long opcode,
> > +					unsigned long arg1,
> > +					unsigned long arg2,
> > +					unsigned long arg3,
> > +					unsigned long arg4,
> > +					unsigned long arg5,
> > +					unsigned long arg6,
> > +					unsigned long arg7,
> > +					unsigned long arg8,
> > +					unsigned long arg9,
> > +					unsigned long *out1,
> > +					unsigned long *out2,
> > +					unsigned long *out3,
> > +					unsigned long *out4,
> > +					unsigned long *out5,
> > +					unsigned long *out6,
> > +					unsigned long *out7,
> > +					unsigned long *out8,
> > +					unsigned long *out9)
> > +{
> > +	long hret = H_SUCCESS;
> > +	int i, sleep_msecs;
> > +
> > +	EDEB_EN(7, "opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx "
> > +		"arg5=%lx arg6=%lx arg7=%lx arg8=%lx arg9=%lx",
> > +		opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
> > +		arg8, arg9);
> > +
> > +
> > +	for (i = 0; i < 5; i++) {
> > +		hret = plpar_hcall_9arg_9ret(opcode,
> > +					    arg1, arg2, arg3, arg4,
> > +					    arg5, arg6, arg7, arg8,
> > +					    arg9,
> > +					    out1, out2, out3, out4,
> > +					    out5, out6, out7, out8,
> > +					    out9);
> > +
> > +		if (H_IS_LONG_BUSY(hret)) {
> > +			sleep_msecs = get_longbusy_msecs(hret);
> > +			msleep_interruptible(sleep_msecs);
> > +			continue;
> > +		}
> 
> Looping five times before giving up seems arbitrary and failure-prone
> on busy systems.

This is the number we came up with after having talked to the H_CALL
developers

> 
> Is msleep_interruptible (as opposed to msleep) really appropriate?
> 
> Hope all the callers of this function are in non-atomic context (but I
> wasn't able to find any callers?).
That's our intention.
We did not find a place where it is used in an atomic context. 

> 
> And this function is too big to be inline.
> 
> 

Ok, function is no longer inline



