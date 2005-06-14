Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVFNDIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVFNDIR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVFNDIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:08:17 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:31374 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261392AbVFNDIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:08:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a/flUjR1GI40COpOSSzopm5gPh4sOwBJtrYYA+uaLWkCtZSTofjcWRe4+zMexJWURdFdAYBoJJZ1wxvHmSxgkaRDHpZsfuhmxdsTFIzbGA+vTBlU40vH4C6tCAHP1Zc1VcHyg8qMOc08USrXVlD8eD6rOMHtoT9B0FQ+Icbl81k=
Message-ID: <2cd57c9005061320084de5d80d@mail.gmail.com>
Date: Tue, 14 Jun 2005 11:08:12 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: "cutaway@bellsouth.net" <cutaway@bellsouth.net>
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000b01c5707e$c189c930$2800000a@pc365dualp2>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <000b01c5707e$c189c930$2800000a@pc365dualp2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, cutaway@bellsouth.net <cutaway@bellsouth.net> wrote:
> In the current exit_thread() implementation, it appears including the I/O
> port map tear down code within the exit_thread() generates enough autovar
> data that the compiler needs to spill 4 registers to the stack resulting in
> (4) PUSH on entry and (4) POP on exit.
> 
> When I tried extracting the map teardown into a seperate function, the
> situation changed dramatically to where NO REGISTERS were being
> pushed/popped in the normal path entry/exit.
> 
> Below is the original generated code, code my proposal generated, and an
> #ifdef'd change that produced this elimination of the PUSH/POP's.
> 
> Unless I'm on drugs, this looks like a solid winner in a fairly important
> code path :)


I see the effect, But I think it would be better to leave the job to
gcc to generate better code for unlikely, imho.

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
