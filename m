Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWKAXsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWKAXsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWKAXsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:48:31 -0500
Received: from smtp-out.google.com ([216.239.45.12]:61762 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750847AbWKAXsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:48:30 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=k34zmVV//gTmW9oVBgEbOJwBIo/al5BXzqMw+af/v8mEbdacIm767zOKE5E+3wr7Y
	yx/NEjScMzHyp1KxrlpyQ==
Message-ID: <6599ad830611011548h4c0273c0xc5a653ea8726a692@mail.gmail.com>
Date: Wed, 1 Nov 2006 15:48:21 -0800
From: "Paul Menage" <menage@google.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
In-Reply-To: <45490F0D.7000804@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061030103356.GA16833@in.ibm.com>
	 <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	 <20061101173356.GA18182@in.ibm.com> <45490F0D.7000804@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/06, Chris Friesen <cfriesen@nortel.com> wrote:
>
> I just thought I'd weigh in on this.  As far as our usage pattern is
> concerned, guarantees cannot be met via limits.
>
> I want to give "x" cpu to container X, "y" cpu to container Y, and "z"
> cpu to container Z.

I agree that these are issues - but they don't really affect the
container framework directly.

The framework should be flexible enough to let controllers register
any control parameters (via the filesystem?) that they need, but it
shouldn't contain explicit concepts like guarantees and limits. Some
controllers won't even have this concept (cpusets doesn't really, for
instance, and  containers don't have to be just to do with
quantitative resource control).

I sent out a patch a while ago that showed how ResGroups could be
turned into effectively a library on top of a generic container system
- so ResGroups controllers could write to the ResGroups interface, and
let the library handle setting up control parameters and parsing
limits and guarantees. I expect the same thing could be done for UBC.

Paul
