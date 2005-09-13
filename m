Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVIMUrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVIMUrD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVIMUrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:47:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61159 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932231AbVIMUrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:47:02 -0400
Message-ID: <4327386B.5050201@redhat.com>
Date: Tue, 13 Sep 2005 16:36:59 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Assar <assar@permabit.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow
References: <78irx6wh6j.fsf@sober-counsel.permabit.com>	<200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>	<784q8qrsad.fsf@sober-counsel.permabit.com>	<200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>	<788xy2qas0.fsf@sober-counsel.permabit.com>	<20050913183948.GE14889@dmt.cnet> <784q8okdfn.fsf@sober-counsel.permabit.com>
In-Reply-To: <784q8okdfn.fsf@sober-counsel.permabit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assar wrote:

>>If thats the reason, you don't need the "-1" there?
>>    
>>
>
>It also writes a 0 byte.  I think it looks like this:
>
>---- ------------ -
>len  string...    0
>
>-
>

NFS uses XDR to encode C strings.  They are encoded as counted byte arrays
and are _not_ null terminated.  The space containing the string is rounded
up to the next 4 byte boundary though and, usually, this space is zero 
filled.
The number of bytes in the string is encoded as a big endian integer in the
first four bytes.

    Thanx...

       ps
