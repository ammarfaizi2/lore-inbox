Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271827AbTHMLmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271129AbTHMLmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:42:47 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:9976 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271933AbTHMLkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:40:24 -0400
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: thunder7@xs4all.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813042544.5064b3f4.akpm@osdl.org>
References: <20030813045638.GA9713@middle.of.nowhere>
	 <20030813014746.412660ae.akpm@osdl.org>
	 <20030813091958.GA30746@gates.of.nowhere>
	 <20030813025542.32429718.akpm@osdl.org>
	 <1060772769.8009.4.camel@localhost.localdomain>
	 <20030813042544.5064b3f4.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060774803.8008.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 12:40:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 12:25, Andrew Morton wrote:
> Like this?
> 
> What happens if someone runs a K6 kernel on a K7?
> Or various other CPU types?  What is the matrix here?

Beats me, but then the prefetch code in 2.6 seems broken from
5 seconds of inspection anyway. We are testing the XMM feature
and using prefetchnta for Athlon, thats wrong for lots of athlon
processors that dont have XMM but do have prefetch/prefetchw,
(which btw also seem to work properly on all these processors
 while prefetchnta seems to do funky things)

Perhaps someone should fix prefetch() before they worry about 
the rest of the mess ?

For Athlon we should be testing 3Dnow, and using prefetch/prefetchw
for Intel cases we want to go for prefetchnta if XMM is set (PIII, PIV)


Alan

