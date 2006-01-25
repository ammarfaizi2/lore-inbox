Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWAYW2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWAYW2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWAYW2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:28:14 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:13287 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932177AbWAYW2N convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:28:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a73sqbT6EmARe7uMRftki2HWh87cDfb+QKDgSyGkDWWfRb2OL4x3gDa6fv6ClqFg1CPHUgf+JBoAkGClT64ymFHnroYPmu6jBOkvoe5oK8O81LOVMyhg16xad4x1h45bbULJhIkfUwJ8FrkW8XfTjnSlow6pA9PR3h3PFoC2XrU=
Message-ID: <4807377b0601251428q4cd0faabve51087052714718@mail.gmail.com>
Date: Wed, 25 Jan 2006 14:28:10 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Olaf Kirch <okir@suse.de>
Subject: Re: e100 oops on resume
Cc: Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <20060125201450.GA15102@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124225919.GC12566@suse.de>
	 <20060124232142.GB6174@inferi.kami.home>
	 <20060125090240.GA12651@suse.de> <20060125121125.GH5465@suse.de>
	 <4807377b0601251137r7621216byc47b03a3c634557c@mail.gmail.com>
	 <20060125201450.GA15102@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/06, Olaf Kirch <okir@suse.de> wrote:
> On Wed, Jan 25, 2006 at 11:37:40AM -0800, Jesse Brandeburg wrote:
> > its an interesting patch, but it raises the question why does
> > e100_init_hw need to be called at all in resume?  I looked back
> > through our history and that init_hw call has always been there.  I
> > think its incorrect, but its taking me a while to set up a system with
> > the ability to resume.
>
> I'll ask the folks here to give it a try tomorrow. But I suspect at
> least some of it will be needed. For instance I assume you'll
> have to reload to ucode when bringing the NIC back from sleep.

I totally agree thats what it looks like, but unless I'm missing
something e100_up will take care of everything, and if the interface
is not up, e100_open->e100_up afterward will take care of it.

we have to be really careful about what might happen when resuming on
a system with a SMBUS link to a BMC, as there are some tricky
transitions in the hardware that can be easily violated.

Jesse
