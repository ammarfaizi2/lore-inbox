Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVIHNcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVIHNcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVIHNcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:32:22 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:4467 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751351AbVIHNcV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:32:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=saElDg2Q/fPuincYS33rlyN57aAewIFcsyQQQCquZs0BJSwwly2oShupRyiyA9LgieEEjm7sYxgvlNfIwEL84FU06RRABiNyczomi6faDDPVWykg01aEvl+AyUUkpHdACsbRvyDfE01bIshniccJbkCpuohUNQ5BmnH4fMdqtYc=
Message-ID: <1e62d1370509080632873c1d1@mail.gmail.com>
Date: Thu, 8 Sep 2005 06:32:20 -0700
From: Fawad Lateef <fawadlateef@gmail.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: Reuse of BIOs
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <11859.1126185451@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11859.1126185451@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, David Howells <dhowells@redhat.com> wrote:
> 
> 
> Is it possible to reuse a BIO once the callback on it has been invoked to
> indicate final completion? Or does it have to be released and another one
> allocated?
> 

The thing which I did in my virtual caching device driver is I keeps
the pointer of BIO got from the kernel in my locally created BIO's
private field (and fill other fields with the original BIO's Data) and
sends it to other caching device and when got the end_io for that BIO
(like in read from caching device and writing to target device) I put
that in the queue and one of my thread directly sends that to the
target device without changed except replacing the sector of caching
device to the target device sector and after getting completion signal
from target device, I just freed that BIO or move it to my free pool
of BIOs and just call the completion for the original BIO taken back
from the private field of local BIO ..........

This means we can reuse BIO sended to one device and then sending that
to other device after getting completion signal from first device
......... But I can't say this about the original kernel BIO b/c I m
not sending it to any of my devices !!!!

-- 
Fawad Lateef
