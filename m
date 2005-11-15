Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVKOTRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVKOTRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVKOTRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:17:42 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:34484 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964972AbVKOTRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:17:42 -0500
Message-ID: <437A3453.6080000@watson.ibm.com>
Date: Tue, 15 Nov 2005 14:17:39 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115010155.GA3792@IBM-BWN8ZTBWAO1> <20051114175140.06c5493a.pj@sgi.com> <20051115022931.GB6343@sergelap.austin.ibm.com> <20051114193715.1dd80786.pj@sgi.com> <20051115051501.GA3252@IBM-BWN8ZTBWAO1> <20051114223513.3145db39.pj@sgi.com> <20051115081100.GA2488@IBM-BWN8ZTBWAO1> <20051115010624.2ca9237d.pj@sgi.com> <20051115190030.GA16790@sergelap.austin.ibm.com>
In-Reply-To: <20051115190030.GA16790@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Paul Jackson (pj@sgi.com):
> 
>>An additional per-task attribute, set by a batch manager typically
>>when it starts a job on a checkpointable, restartable, movable
>>"virtual server" connects the job parent task, and hence all its
>>descendents in that job, with a named kernel object that has among its
>>attributes a pid range.  When fork is handing out new pids, it honors
>>that pid range.  User level code, in the batch manager or system
>>administration layer manages a set of these named virtual servers,
>>including assigning pid ranges to them, and puts what is usually the
>>same such configuration on each server in the farm.
> 

And that's how we implement this.
The difference is that the pidrange-id is assigned on the fly,
that is when the virtual server is created or recreated after restart.

This, as described in my previous note, is more scalable, because I don't have
to do a global pidrange partitioning.
global pidrange partitioning has implications, for instance what if I simply
want to freeze an app only to restart it much later. This would freeze that
range autmatically.

On process restart, we force fork to use a particular <pidspace/pid> for its
kernel pid assignment, rather then searching for a free one.

-- Hubertus



