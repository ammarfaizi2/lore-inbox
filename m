Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWITRag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWITRag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWITRag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:30:36 -0400
Received: from smtp-out.google.com ([216.239.45.12]:54201 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932101AbWITRaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:30:35 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=qJRre0v+1TXcNy+gPWXtygCRjNFT2/AvJTCnV1vj+3/xlb+0UTaWnFVUg9iJ/Nc5A
	ZlDF8Me9RSs5N8Xrm0WeA==
Message-ID: <6599ad830609201030w38b6ae59ia0d4a4ccabb47054@mail.google.com>
Date: Wed, 20 Sep 2006 10:30:24 -0700
From: "Paul Menage" <menage@google.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Cc: "Christoph Lameter" <clameter@sgi.com>, npiggin@suse.de,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, pj@sgi.com,
       "Rohit Seth" <rohitseth@google.com>, devel@openvz.org
In-Reply-To: <1158773699.7705.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773699.7705.19.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> I'm also not clear how you handle shared pages correctly under the fake
> node system, can you perhaps explain that further how this works for say
> a single apache/php/glibc shared page set across 5000 containers each a
> web site.

If you can associate files with containers, you can have a "shared
libraries" container that the libraries/binaries for apache/php/glibc
are associated with - all pages from those files are then accounted to
the shared container. So you can see that there are 5000 apaches each
using say 10MB privately, and sharing a container with 100MB of file
data. This can also be O(1) in the number of apache containers.

Paul
