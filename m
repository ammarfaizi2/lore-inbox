Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVFNHqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVFNHqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 03:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVFNHoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 03:44:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:36015 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261312AbVFNHno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 03:43:44 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: <cutaway@bellsouth.net>, "Coywolf Qi Hunt" <coywolf@gmail.com>
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
Date: Tue, 14 Jun 2005 10:43:03 +0300
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>
References: <000b01c5707e$c189c930$2800000a@pc365dualp2> <2cd57c9005061320084de5d80d@mail.gmail.com> <002401c57099$394f9070$2800000a@pc365dualp2>
In-Reply-To: <002401c57099$394f9070$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506141043.03502.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 07:26, cutaway@bellsouth.net wrote:
> The problem with that approach is GCC would still just relocate the push/pop
> block to the bottom of the function.  This means you won't be likely to pick
> up anything useful in L1 or L2 as the function exits normally - in fact
> you'd typically be guaranteed to be picking up a partial line of gorp that
> is completely worthless later on.
> 
> This is one of my issues with the notion of unlikely() being smoothed on
> everywhere like Bondo<g> - it also makes it "unlikely" that you'll get any
> serendipitous L1/L2 advantages that could be had by locating related
> functions next to each other.
> 
> When you take the unlikely stuff completely out of line in a seperate
> functions located elsewhere, the mainline code can make better use of the
> caches.  The Intel parts thrive on L1 hits and die if they're not getting
> them.

That's exactly what compiler can do by itself. The fact that currently
it isn't smart enough to od it means that it has to be improved.
You propose that people have to do compiler's job.
--
vda

