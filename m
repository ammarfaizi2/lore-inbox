Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVLGPfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVLGPfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVLGPfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:35:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55739 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751137AbVLGPfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:35:10 -0500
Message-ID: <4397011E.9010703@redhat.com>
Date: Wed, 07 Dec 2005 10:34:54 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: another nfs puzzle
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>	 <4396EB2F.3060404@redhat.com>	 <1133964667.27373.13.camel@lade.trondhjem.org>  <4396EF50.30201@redhat.com> <1133966063.27373.29.camel@lade.trondhjem.org>
In-Reply-To: <1133966063.27373.29.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>>Yup, same problem.  Why is this allowed?  Does it really work correctly?
>>    
>>
>
>Assuming that the processes have _some_ method of synchronisation, then
>I cannot see why it shouldn't be workable. Come to think of it, it might
>even be possible to use O_DIRECT to provide that synchronisation (use
>O_DIRECT to set a "lock" on the page, then modify it using mmap). 
>
>Whether or not there are people out there that actually _want_ to do
>this is a different matter.
>

Mixing O_DIRECT i/o and cached i/o is probably a recipe for disaster,
unless the cooperating programs are very careful and very aware of how
the particular file system in the particular kernel implements direct
i/o and caching, including cache validation.

This seems like a dangerous enough area that denying mmap on a file which
has been opened with O_DIRECT by any process and denying open(O_DIRECT)
on a file which has been mmap'd would be a good thing.  These things are
easy enough to keep track of, so it shouldn't be too hard to implement.

    Thanx...

       ps
