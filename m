Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWEVMK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWEVMK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWEVMK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:10:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62849 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750785AbWEVMK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:10:27 -0400
Date: Mon, 22 May 2006 07:10:24 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060522121024.GB6025@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <m1sln61jqs.fsf@ebiederm.dsl.xmission.com> <20060521162759.GA19707@sergelap.austin.ibm.com> <m1verzntca.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1verzntca.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> >
> > Here are the numbers with the basic patchsets.  But I guess I should
> > do another round with adding 7 more void*'s to represent additional
> > namespaces.
> 
> I'm a little slow coming up to speed on these benchmarks.
> dbench and tbench are measured in megabytes per second correct?
> kernbench is the number of seconds it takes to compile a kernel?
> reaim is measured in jobs per minute?
> 
> So if I read this right the differences are currently in
> the noise levels, from your testing.

Yup.

Adding 7 extra void*'s seems to affect only dbench, which
whose degration with the nsproxy falls outside the noise.
The odd thing isn't so much the degradation, but the widely
scattered values, compared to without nsproxy.

           |  with nsproxy  |   without nsproxy |
kernbench  | 70.23 +/- 0.27 |   70.04 +/- 0.22  |
dbench     | 367.1 +/- 32.6 |   410.0 +/- 2.96  |
tbench     | 399.3 +/- 12.4 |   399.4 +/- 12.5  |


reaim with nsproxy
1 115600.000000 5512.441557
3 243099.998000 10876.225044
5 270002.798667 11800.545221
7 283291.578667 10897.147984
9 294530.528000 7095.760045
11 nan nan
13 nan nan
15 nan nan

reaim without nsproxy
1 114240.000000 5728.697311
3 254271.426000 11767.994417
5 279965.036000 12615.448140
7 281660.000000 9898.028733
9 302905.264000 5165.026561
11 nan nan
13 nan nan
15 nan nan
